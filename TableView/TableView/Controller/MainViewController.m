//
//  MainViewController.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewViewController.h"
#import "TableViewAndCollectionViewController.h"
#import "CalendarViewController.h"


static NSString *tableViewCellIdentifier=@"TableViewCellIdentifier";

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor lightGrayColor];

    [self.view addSubview:self.tableView];

}


// tableView
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,APPW,APPH) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        self.tableView.tableFooterView=[UIView new];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellIdentifier];
    }
    return _tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    NSArray *arr=@[@"TableViewViewController",@"TableViewAndCollectionViewController",@"CalendarViewController"];
    cell.textLabel.text=arr[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kmargin*5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==0)
    {
        [self.navigationController pushViewController:[TableViewViewController new] animated:NO];
    }
    else if (indexPath.row==1)
    {
       [self.navigationController pushViewController:[TableViewAndCollectionViewController new] animated:NO];
    }
    else
    {
       [self.navigationController pushViewController:[CalendarViewController new] animated:NO];
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
