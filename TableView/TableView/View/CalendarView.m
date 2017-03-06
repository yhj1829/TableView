//
//  CalendarView.m
//  TableView
//
//  Created by yhj on 2017/3/6.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "CalendarView.h"
#import "DateCollectionViewCell.h"

static NSString *DateCollectionViewCellIdentifier=@"DateCollectionViewCellIdentifier";
static NSString *CollectionViewCellIdentifier=@"CollectionViewCellIdentifier";

@interface CalendarView ()

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UILabel *monthLabel;

@property(nonatomic,strong)NSArray *weekDayArr;

@property(nonatomic,strong)UIView *mainView;

@end

@implementation CalendarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        [self initView];

        self.backgroundColor=RGBColor(178,178,178);

        [self addTap];

    }
    return self;
}

-(void)addTap
{
    UISwipeGestureRecognizer *swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(next)];
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pass)];
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];

}

-(void)next
{
    // 上一个月切换
    [UIView transitionWithView:self duration:.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{

        self.date=[self lastMonth:self.date];

    } completion:^(BOOL finished) {
        
    }];
}


-(void)pass
{
    // 下一个月切换
    [UIView transitionWithView:self duration:.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{

        self.date=[self nextMonth:self.date];

    } completion:^(BOOL finished) {
        
    }];
}


-(void)initView
{

    _weekDayArr=@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    _mainView=[[UIView alloc]initWithFrame:CGRectMake(0,0,APPW,APPW)];
    _mainView.backgroundColor=RGBColor(170,170,170);
    [self addSubview:_mainView];
    for (int i=0;i<2;i++)
    {
        UIButton *btn=[UIButton new];
        btn.tag=i;
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:[UIColor blueColor] forState:0];
        [_mainView addSubview:btn];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        if (i) {
            [btn setTitle:@"下个月" forState:0];
            btn.frame=CGRectMake(kmargin,kmargin,kmargin*6,APPW/7-kmargin);
        }
        else
        {
            [btn setTitle:@"上个月" forState:0];
            btn.frame=CGRectMake(APPW-kmargin*7,kmargin,kmargin*6,APPW/7-kmargin);
        }
    }


    _monthLabel=[_mainView getLabelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByTruncatingTail numberOfLines:1];
    [_mainView addSubview:_monthLabel];
    _monthLabel.frame=CGRectMake((APPW-160)/2,kmargin*3/2,160,kmargin*2);

    UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
    flowLayout.sectionInset=UIEdgeInsetsMake(0,0,0,0);
    flowLayout.itemSize=CGSizeMake(APPW/7,APPW/7);
    flowLayout.minimumLineSpacing=0;
    flowLayout.minimumInteritemSpacing=0;

    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,APPW/7,APPW,APPH) collectionViewLayout:flowLayout];
    [_mainView addSubview:_collectionView];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.scrollEnabled=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;

    [_collectionView registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:DateCollectionViewCellIdentifier];

}

-(void)btnEvent:(UIButton *)btn
{
    if (btn.tag==0)
    {
        // 上一个月切换
      [UIView transitionWithView:self duration:.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{

          self.date=[self lastMonth:self.date];

      } completion:^(BOOL finished) {

      }];

    }
    else
    {
        // 下一个月切换
        [UIView transitionWithView:self duration:.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{

            self.date=[self nextMonth:self.date];

        } completion:^(BOOL finished) {

        }];
    }
}

-(void)setDate:(NSDate *)date
{
    _date=date;
    _monthLabel.text=[NSString stringWithFormat:@"%ld年%ld月",(long)[self year:date],(long)[self month:date]];
    _monthLabel.font=[UIFont systemFontOfSize:12];
    [_collectionView reloadData];

}

// 这个月的天数
-(NSInteger)day:(NSDate *)date
{
    NSDateComponents *components=[[NSCalendar currentCalendar]components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    return [components day];
}

// 这个月第一天是周几
-(NSInteger)firstWeekDayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    // 设定每周的第一天从星级几开始 1:星期日 2:星期一
    [calendar setFirstWeekday:1];
    NSDateComponents *components=[[NSCalendar currentCalendar]components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    [components setDay:1];
    NSDate *firstDayOfMonthDate=[calendar dateFromComponents:components];
    NSUInteger firstWeekDay=[calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekDay-1;
}

// 这个月有几天
-(NSInteger)totalDaysInMonth:(NSDate *)date
{
    NSRange daysInLastMonth=[[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

// 上个月的时间
-(NSDate *)lastMonth:(NSDate *)date
{
    NSDateComponents *dateComponents=[NSDateComponents new];
    dateComponents.month=-1;
    NSDate *newDate=[[NSCalendar currentCalendar]dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

// 下个月的时间
-(NSDate *)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents=[NSDateComponents new];
    dateComponents.month=+1;
    NSDate *newDate=[[NSCalendar currentCalendar]dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

// 第几个月
-(NSInteger)month:(NSDate *)date
{
    NSDateComponents *components=[[NSCalendar currentCalendar]components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    return [components month];
}

// 哪年
-(NSInteger)year:(NSDate *)date
{
    NSDateComponents *components=[[NSCalendar currentCalendar]components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    return [components year];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return self.weekDayArr.count;
    }
    else
    {
        return 49;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DateCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:DateCollectionViewCellIdentifier forIndexPath:indexPath];
    if (indexPath.section==0)
    {
        cell.nameLabel.text=self.weekDayArr[indexPath.row];
        cell.nameLabel.textColor=[UIColor brownColor];
    }
    else
    {
        // 这个月的总天数
        NSInteger daysInMonth=[self totalDaysInMonth:_date];

        // 这个月第一天是周几
        NSInteger firstWeekDay=[self firstWeekDayInThisMonth:_date];
        NSLog(@"111--%ld  222--%ld  99--%ld",(long)daysInMonth,(long)firstWeekDay,(long)indexPath.row);
        NSInteger day=0;;

        NSInteger i=indexPath.row;
        // 这个月第一天之前的不显示
        if (i<firstWeekDay)
        {
          cell.nameLabel.text=@"";
        }
        // 这个月最后一天之后的不显示
        else if (i>firstWeekDay+daysInMonth-1)
        {
            cell.nameLabel.text=@"";
        }
        else
        {
            day=i-firstWeekDay+1;
            cell.nameLabel.text=[NSString stringWithFormat:@"%ld",(long)day];
            cell.nameLabel.textColor=[UIColor blackColor];
            // 如果当前日历上的时间和今天的时间一样的话
            if ([_today isEqualToDate:_date])
            {
                // 如果日期一样的话 为红色
                if (day==[self day:_date])
                {
                    cell.nameLabel.textColor=[UIColor redColor];
                }
                // 如果日期为今天之后的 还未过
                else if (day>[self day:_date])
                {
                    cell.nameLabel.textColor=RGBColor(150,150,150);
                }
            }
            else if ([_today compare:_date]==NSOrderedAscending)
            {
                cell.nameLabel.textColor=RGBColor(150,150,150);
            }
        }
    }
    return cell;
}

@end
