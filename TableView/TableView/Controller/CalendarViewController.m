//
//  CalendarViewController.m
//  TableView
//
//  Created by yhj on 2017/3/4.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCalendarView];
}

-(void)initCalendarView
{
    CalendarView *calendarView=[[CalendarView alloc]initWithFrame:CGRectMake(0,64,APPW,APPW-64)];
    [self.view addSubview:calendarView];
    calendarView.today=[NSDate date];
    calendarView.date=calendarView.today;
    calendarView.calendarBlock=^(NSInteger day,NSInteger month,NSInteger year)
    {
        NSLog(@"sdhgdsgs--%ld 777--%ld  888--%ld",(long)day,(long)month,(long)year);

    };
}

@end
