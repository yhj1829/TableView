//
//  CalendarView.h
//  TableView
//
//  Created by yhj on 2017/3/6.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CalendarBlock)(NSInteger day,NSInteger month,NSInteger year);

@interface CalendarView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,strong)NSDate *today;

@property(nonatomic,copy)CalendarBlock  calendarBlock;

@end
