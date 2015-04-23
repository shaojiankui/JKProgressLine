//
//  JKProgressLine.m
//  JKProgressLine
//
//  Created by Jakey on 15/3/24.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "JKProgressLine.h"

@implementation JKProgressLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buidView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self buidView];
}

-(void)buidView{
    self.backgroundColor = [UIColor clearColor];

}

- (void)drawRect:(CGRect)rect
{
    
    NSInteger nums = [self.items count];
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    CGContextSaveGState(context) ;
    CGContextSetAllowsAntialiasing(context, TRUE) ;

//    //Fill Main Path
//    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
//    CGContextFillRect(context, CGRectMake(rect.size.width/2-self.lineWidth/2, 0, self.lineWidth, rect.size.height));
//    CGContextSaveGState(context);
//    CGContextRestoreGState(context);
//    
//    CGContextSaveGState(context);
//    
    
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    (CGFloat[]){
                                                                        1.0f, 1.0f, 1.0f, 1.0f,
                                                                        0.639f, 0.639f, 0.639f, 1.0f,
                                                                        0.443f, 0.443f, 0.443f, 1.0f
                                                                    },
                                                                    (CGFloat[]){
                                                                        0.0f,
                                                                        0.7f,
                                                                        1.0f
                                                                    },
                                                                    3);
  
    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(rect.size.width/2-(self.itemWidth/4)/2, 0, (self.itemWidth/4), rect.size.height)];
    //添加剪切路径
    [path addClip];
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(rect.size.width, rect.size.height), 0);
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    // 释放渐变对象
    CGGradientRelease(gradientRef);
    CGContextRestoreGState(context);


    //绘制点
    CGContextSaveGState(context);
    CGFloat y = rect.origin.y+self.edge.top;
    CGFloat x = rect.size.width/2-self.itemWidth/2;
    for (int i = 0; i < nums; i++)
    {
        UIColor *color;
        CGRect itemRect;
        if (i == self.selectedIndex)
        {
            color = self.selectColor;
        }
        else if(i < self.selectedIndex)
        {
            color =self.doneColor;
        }
        else
        {
           color = self.normalColor;
        }
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(x-1, y-1, self.itemWidth+2, self.itemWidth+2));
        
        itemRect = CGRectMake(x+self.itemWidth/4, y+self.itemWidth/4, self.itemWidth/2, self.itemWidth/2);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:itemRect];
        circlePath.lineWidth = self.itemWidth/2;
        [[UIColor whiteColor] setFill];
        [color setStroke];
        [circlePath stroke];
        [circlePath fill];
        
        y += self.itemWidth + self.itemMargin;
    }
    
}

#pragma mark --setter method
-(void)setTouchedLineBlock:(TouchedLineBlock)touchedLineBlock{
    _touchedLineBlock = [touchedLineBlock copy];
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    if (_selectedIndex == selectedIndex)
        return ;
    _selectedIndex = MIN(MAX(0, selectedIndex), [self.items count] - 1) ;
    
    [self setNeedsDisplay] ;
}
-(void)setItems:(NSArray *)items{
    _items = items;
    
    [self setNeedsDisplay] ;
}
-(void)setEdge:(UIEdgeInsets)edge{
    _edge = edge;
    [self reLayout];
    [self setNeedsDisplay] ;

}
-(void)setItemMargin:(CGFloat)itemMargin{
    _itemMargin = itemMargin;
    [self reLayout];
    [self setNeedsDisplay] ;
}
-(void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
    [self reLayout];
    [self setNeedsDisplay] ;
}
- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor ;
    [self setNeedsDisplay] ;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor ;
    [self setNeedsDisplay] ;
}
-(void)setDoneColor:(UIColor *)doneColor{
    _doneColor = doneColor;
    [self setNeedsDisplay] ;
}
-(void)reLayout{
   self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _itemWidth,self.edge.top + self.edge.bottom +  [self.items count] *(self.itemMargin+_itemWidth));
}
#pragma mark Touches handlers
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    CGPoint point = [theTouch locationInView:self];

    NSInteger  currentPage = (point.y-self.edge.top)/(self.itemMargin+self.itemWidth/2);
    if (_touchedLineBlock) {
        _touchedLineBlock(currentPage,self.items[currentPage]);
    }
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}
@end
