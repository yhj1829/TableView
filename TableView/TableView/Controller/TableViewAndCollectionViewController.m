//
//  TableViewAndCollectionViewController.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "TableViewAndCollectionViewController.h"

#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

#import "FoodCategoryModel.h"
#import "TableViewHeaderView.h"

#import "CategoryModel.h"
#import "CollectionViewFlowLayout.h"

#import "CollectionViewCell.h"
#import "CollectionViewHeaderView.h"

#import "JGCollectionCategoryModel.h"

static NSString *LeftTableViewCellIdentifier=@"LeftTableViewCellIdentifier";
static NSString *CollectionViewCellIdentifier=@"CollectionViewCellIdentifier";
static NSString *CollectionViewHeaderIdentifier=@"CollectionViewHeaderIdentifier";
@interface TableViewAndCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,strong)NSMutableArray *leftArr;

@property(nonatomic,strong)NSMutableArray *rightArr;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,assign)BOOL isScrollDown;

@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation TableViewAndCollectionViewController

-(void)initData
{
    _leftArr=[NSMutableArray array];

    _rightArr=[NSMutableArray array];

    _selectIndex=0;

    _isScrollDown=YES;

    NSString *path=[[NSBundle mainBundle]pathForResource:@"liwushuo.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSArray *categories=dic[@"data"][@"categories"];

    for (NSDictionary *dic in categories) {
        CategoryModel *categoryModel=[CategoryModel mj_objectWithKeyValues:dic];
        [self.leftArr addObject:categoryModel];
        NSMutableArray *data=[NSMutableArray array];
        for (SubcategoriesModel *subcategoriesModel in categoryModel.subcategories)
        {
            [data addObject:subcategoriesModel];
        }
        [self.rightArr addObject:data];
    }

    [self.leftTableView reloadData];
    
    [self.collectionView reloadData];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor lightGrayColor];

    [self.view addSubview:self.leftTableView];

    [self.view addSubview:self.collectionView];

    [self initData];

    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
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

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CollectionViewFlowLayout *flowLayout=[CollectionViewFlowLayout new];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing=kmargin/2;
        flowLayout.minimumInteritemSpacing=kmargin/2;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(APPW/3+1+kmargin/2,64+kmargin/2,APPW*2/3-1-kmargin,APPH-64-kmargin) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.backgroundColor=[UIColor lightGrayColor];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
        [_collectionView registerClass:[CollectionViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionViewHeaderIdentifier];
    }
    return _collectionView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:LeftTableViewCellIdentifier];
    cell.categoryModel=self.leftArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex=indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kmargin*5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.leftArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CategoryModel *categoryModel=self.leftArr[section];
    return categoryModel.subcategories.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    SubcategoriesModel *subcategoriesModel=self.rightArr[indexPath.section][indexPath.item];
    cell.subcategoriesModel=subcategoriesModel;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseIdentifier=CollectionViewHeaderIdentifier;
    }
    CollectionViewHeaderView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    view.backgroundColor=[UIColor whiteColor];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CategoryModel *categoryModel=self.leftArr[indexPath.section];
        view.nameLabel.text=categoryModel.name;
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((APPW*2/3-1-kmargin*2)/3,(APPW*2/3-1-kmargin*2)/3+kmargin*2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(APPW*2/3-1,30);
}


// 分区head即将展示时
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
     // 当前的collectionView滚动的方向向上，collectionView是用户拖拽而产生滚动的（（主要判断collectionView用户拖拽而滚动的，还是点击leftTableView而滚动的）
    if (!_isScrollDown&&collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// 分区head展示结束时
-(void)
collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前的collectionView滚动的方向向下，collectionView是用户拖拽而产生滚动的（（主要判断collectionView用户拖拽而滚动的，还是点击leftTableView而滚动的）
    if (_isScrollDown&&collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section+1];
    }
}


// 当拖动右边collectionView的时候，处理左边leftTableView
-(void)selectRowAtIndexPath:(NSInteger)index
{
  [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffSetY=0;
    UICollectionView *collectionView=(UICollectionView *)scrollView;
    if (_collectionView==collectionView) {
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
