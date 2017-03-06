//
//  TableViewViewController.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "TableViewViewController.h"

#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

#import "FoodCategoryModel.h"
#import "TableViewHeaderView.h"

static NSString *LeftTableViewCellIdentifier=@"LeftTableViewCellIdentifier";
static NSString *RightTableViewCellIdentifier=@"RightTableViewCellIdentifier";
@interface TableViewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,strong)NSMutableArray *leftArr;

@property(nonatomic,strong)NSMutableArray *rightArr;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,assign)BOOL isScrollDown;

@end

@implementation TableViewViewController

-(void)initData
{
    _leftArr=[NSMutableArray array];

    _rightArr=[NSMutableArray array];

    _selectIndex=0;

    _isScrollDown=YES;

    NSString *path=[[NSBundle mainBundle]pathForResource:@"meituan.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods=dic[@"data"][@"food_spu_tags"];
    for (NSDictionary *dic in foods)
    {
        FoodCategoryModel *foodCategoryModel=[FoodCategoryModel mj_objectWithKeyValues:dic];
        [self.leftArr addObject:foodCategoryModel];

        NSMutableArray *data=[NSMutableArray array];
        for (FoodNameModel *foodName in foodCategoryModel.spus)
        {
            [data addObject:foodName];
        }
        [self.rightArr addObject:data];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor lightGrayColor];

    [self.view addSubview:self.leftTableView];

    [self.view addSubview:self.rightTableView];

    [self initData];

    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}


// leftTableView
-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,APPW/3,APPH) style:UITableViewStylePlain];
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
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(APPW/3+1,64,APPW*2/3,APPH-64) style:UITableViewStylePlain];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (_leftTableView==tableView)?1:self.leftArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_leftTableView==tableView)?self.leftArr.count:[self.rightArr[section]count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView)
    {
        LeftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:LeftTableViewCellIdentifier];
        cell.foodCategoryModel=self.leftArr[indexPath.row];
        return cell;
    }
    else
    {
        RightTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:RightTableViewCellIdentifier];
        cell.foodNameModel=self.rightArr[indexPath.section][indexPath.row];
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (_rightTableView==tableView)?kmargin*3:0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableViewHeaderView *headView=[TableViewHeaderView new];
    FoodNameModel *foodNameModel=self.leftArr[section];
    headView.nameLabel.text=foodNameModel.name;
    return (_rightTableView==tableView)?headView:nil;
}

// 分区head即将展示时
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是rightTableView，rightTableView滚动的方向向上，rightTableView是用户拖拽而产生滚动的（（主要判断rightTableView用户拖拽而滚动的，还是点击leftTableView而滚动的）
    if ((_rightTableView==tableView)&&!_isScrollDown&&_rightTableView.dragging) {
        [self selectRowAtIndexPath:section];
    }
}

// 当拖动右边rightTableView的时候，处理左边leftTableView
-(void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

// 分区head展示结束时
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是rightTableView，rightTableView滚动的方向向上，rightTableView是用户拖拽而产生滚动的（（主要判断rightTableView用户拖拽而滚动的，还是点击leftTableView而滚动的）
    if ((_rightTableView==tableView)&&_isScrollDown&&_rightTableView.dragging) {
        [self selectRowAtIndexPath:section+1];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView!=tableView) {
        return;
    }
    _selectIndex=indexPath.row;
    [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffSetY=0;
    UITableView *tableView=(UITableView *)scrollView;
    if (_rightTableView==tableView) {
        _isScrollDown=lastOffSetY<scrollView.contentOffset.y;
        lastOffSetY=scrollView.contentOffset.y;
    }
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
