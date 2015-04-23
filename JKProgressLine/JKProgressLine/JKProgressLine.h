//
//  JKProgressLine.h
//  JKProgressLine
//
//  Created by Jakey on 15/3/24.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedLineBlock)(NSInteger index,NSString*title);

@interface JKProgressLine : UIControl
{
    TouchedLineBlock _touchedLineBlock;
}
-(void)setTouchedLineBlock:(TouchedLineBlock)touchedLineBlock;
//时间点的宽
@property (nonatomic) CGFloat itemWidth;
//时间的的距离
@property (nonatomic) CGFloat itemMargin;
//时间点数量
@property(nonatomic, strong) NSArray *items;
//当前时间点
@property(nonatomic) NSInteger selectedIndex;

//正常时候的颜色
@property (nonatomic) UIColor *normalColor;
//当前颜色
@property (nonatomic) UIColor *selectColor;
//完成颜色
@property (nonatomic) UIColor *doneColor;
//上下距离
@property (nonatomic) UIEdgeInsets edge;

@end
