//
//  ViewController.m
//  Demo
//
//  Created by yhj on 2017/2/28.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "ViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

#import "ListModel.h"
#import "HomeModel.h"

static NSString *LeftTableViewCellIdentifier=@"LeftTableViewCellIdentifier";
static NSString *RightTableViewCellIdentifier=@"RightTableViewCellIdentifier";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,strong)NSMutableArray *leftArr;

@property(nonatomic,strong)NSMutableArray *rightArr;

@property(nonatomic,strong)NSMutableDictionary *typeDic;

@property(nonatomic,copy)NSString *typeStr;

@end

@implementation ViewController

-(void)initData
{
    _leftArr=[NSMutableArray array];

    _rightArr=[NSMutableArray array];

    _typeDic=[NSMutableDictionary dictionary];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor lightGrayColor];

     [self.view addSubview:self.leftTableView];

    [self.view addSubview:self.rightTableView];

    [self initData];

    [self getLeftData];

    [self getRightData];

}

-(void)getLeftData
{
    [API GetLeftDataWithSuccess:^(id response)
     {
        self.leftArr=response[@"list"];

        [self.leftTableView reloadData];

        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];

        [self getFirstRightData:self.leftArr[0][@"id"]];

    } failure:^(id error) {

    }];

    [self.view addSubview:self.leftTableView];
}


-(void)getRightData
{
    // 下拉刷新数据
    self.rightTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{

        NSDictionary *dic=self.leftArr[self.leftTableView.indexPathForSelectedRow.row];

        NSString *cellID=dic[@"id"];

        self.typeStr=cellID;
        [API GetRightDataByUserID:cellID success:^(id response) {

            NSLog(@"sdjhhfdh--%@",response);

            NSMutableArray *muArr=[NSMutableArray array];
            [muArr addObjectsFromArray:[ListModel mj_objectArrayWithKeyValuesArray:response[@"list"]]];

            HomeModel *homeModel=[HomeModel new];
            homeModel.listArr=muArr;
            homeModel.next_page=response[@"next_page"];
            homeModel.total_page=response[@"total_page"];
            [self.typeDic setValue:homeModel forKey:cellID];

            self.rightArr=homeModel.listArr;

            [self.rightTableView.mj_header endRefreshing];
            [self.rightTableView.mj_footer endRefreshing];

            [self.rightTableView reloadData];

        } failure:^(id error) {

            [self.rightTableView.mj_header endRefreshing];
            [self.rightTableView.mj_footer endRefreshing];

        }];

        [self.rightTableView.mj_header endRefreshing];

    }];


    // 上拉加载更多数据
    self.rightTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        NSDictionary *dic=self.leftArr[self.leftTableView.indexPathForSelectedRow.row];
        NSString *cellID=dic[@"id"];
        HomeModel *homeModel=self.typeDic[cellID];

        [API GetMoreDataByUserID:cellID page:homeModel.next_page success:^(id response) {

            NSMutableArray *muArr=[NSMutableArray array];
            muArr=homeModel.listArr;
            [muArr addObjectsFromArray:[ListModel mj_objectArrayWithKeyValuesArray:response[@"list"]]];
            homeModel.listArr=muArr;
            homeModel.next_page=response[@"next_page"];
            homeModel.total_page=response[@"total_page"];
            [self.typeDic setValue:homeModel forKey:cellID];

            self.rightArr=homeModel.listArr;

            if(self.typeStr!=cellID)
            {
                return ;
            }

            NSInteger nextPage=[response[@"next_page"] integerValue];
            NSInteger totalPage=[response[@"total_page"] integerValue];

            if ((nextPage-1)==totalPage)
            {
                [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                [self.rightTableView.mj_footer endRefreshing];
            }
             [self.rightTableView reloadData];
            
        } failure:^(id error) {
            
            [self.rightTableView.mj_footer endRefreshing];
            
        }];
        
    }];
    
    self.rightTableView.mj_footer.hidden=YES;
    [self.view addSubview:self.rightTableView];

}


-(void)getFirstRightData:(NSString *)userID
{
    [self.rightTableView.mj_header beginRefreshing];
    [self.rightTableView.mj_footer beginRefreshing];

    [API GetRightDataByUserID:userID success:^(id response) {

        NSMutableArray *muArr=[NSMutableArray array];
    [muArr addObjectsFromArray:[ListModel mj_objectArrayWithKeyValuesArray:response[@"list"]]];

        HomeModel *homeModel=[HomeModel new];
        homeModel.listArr=muArr;
        homeModel.next_page=response[@"next_page"];
        homeModel.total_page=response[@"total_page"];
        [self.typeDic setValue:homeModel forKey:userID];

        self.rightArr=homeModel.listArr;

        [self.rightTableView.mj_header endRefreshing];

        self.rightTableView.mj_footer.hidden=NO;

        [self.rightTableView reloadData];

    } failure:^(id error) {

        [self.rightTableView.mj_header endRefreshing];

        [self.rightTableView.mj_footer endRefreshing];

    }];

}

// leftTableView
-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,APPW/4,APPH) style:UITableViewStylePlain];
        _leftTableView.dataSource=self;
        _leftTableView.delegate=self;
        _leftTableView.backgroundColor=[UIColor whiteColor];
        _leftTableView.showsVerticalScrollIndicator=NO;
        _leftTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.leftTableView.tableFooterView=[UIView new];
        [self.leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:LeftTableViewCellIdentifier];
    }
    return _leftTableView;
}

// rightTableView
-(UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(APPW/4+1,64,APPW*3/4,APPH-64) style:UITableViewStylePlain];
        _rightTableView.dataSource=self;
        _rightTableView.delegate=self;
        _rightTableView.backgroundColor=[UIColor whiteColor];
        _rightTableView.showsVerticalScrollIndicator=NO;
        _rightTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        self.rightTableView.tableFooterView=[UIView new];
        [self.rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:RightTableViewCellIdentifier];
    }
    return _rightTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTableView)
    {
        return self.leftArr.count;
    }
    else
    {
        return self.rightArr.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView)
    {
        LeftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:LeftTableViewCellIdentifier];
        [cell configWithDic:self.leftArr[indexPath.row]];
        return cell;
    }
    else
    {
        RightTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:RightTableViewCellIdentifier];
        cell.listModel=self.rightArr[indexPath.row];
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView)
    {
        return kmargin*5;
    }
    else
    {
        return kmargin*8;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView)
    {
        NSDictionary *dic=self.leftArr[indexPath.row];
        NSString *cellID=dic[@"id"];
        HomeModel *homeModel=self.typeDic[cellID];
        self.typeStr=cellID;
        if (homeModel.listArr==0)
        {
            self.rightTableView.mj_footer.hidden=YES;

            [self.rightTableView.mj_header beginRefreshing];

            [API GetRightDataByUserID:cellID success:^(id response)
             {
//                 NSArray *arr=[ListModel mj_objectArrayWithKeyValuesArray:response[@"list"]];
                 NSMutableArray *muArr=[NSMutableArray array];
                 [muArr addObjectsFromArray:[ListModel mj_objectArrayWithKeyValuesArray:response[@"list"]]];
                 homeModel.listArr=muArr;
                 homeModel.next_page=response[@"next_page"];
                 homeModel.total_page=response[@"total_page"];
                 [self.typeDic setValue:homeModel forKey:cellID];
                 self.rightArr=homeModel.listArr;
                 if (self.typeStr!=cellID)
                 {
                     return ;
                 }

                 [self.rightTableView.mj_header endRefreshing];

                 [self.rightTableView reloadData];
                 self.rightTableView.mj_footer.hidden=NO;

                 NSInteger nextPage=[response[@"next_page"] integerValue];
                 NSInteger totalPage=[response[@"total_page"] integerValue];

                 if ((nextPage-1)==totalPage)
                 {
                     [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
                 }
                 else
                 {
                     [self.rightTableView.mj_footer endRefreshing];
                 }

             } failure:^(id error) {
                 
             }];
        }
        else
        {
            self.rightArr=homeModel.listArr;
            [self.rightTableView reloadData];
            
            NSInteger nextPage=[homeModel.next_page integerValue];
            NSInteger totalPage=[homeModel.total_page integerValue];
            
            if ((nextPage-1)==totalPage)
            {
                [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }
    //    else
    //    {
    ////        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    }
    
}

// 间隙置边
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
