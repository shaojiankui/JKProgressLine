//
//  ViewController.m
//  JKProgressLine
//
//  Created by Jakey on 15/4/23.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.line.edge = UIEdgeInsetsMake(40, 0, 40, 0);
    self.line.items = @[@"test",@"哈哈",@"122343",@"12df3",@"12sdf3"];
    self.line.itemWidth = 8;
    self.line.itemMargin = 80;
    self.line.doneColor = [UIColor colorWithRed:0.278 green:0.600 blue:0.227 alpha:1.000];
    self.line.selectColor = [UIColor colorWithRed:0.757 green:0.000 blue:0.141 alpha:1.000];
    self.line.normalColor = [UIColor colorWithWhite:0.480 alpha:0.600];
    self.line.selectedIndex = 3;
    [self.line setTouchedLineBlock:^(NSInteger index, NSString *title) {
        NSLog(@"click%zd title%@",index,title);
    }];
    
    
    JKProgressLine *lineCode=[[JKProgressLine alloc]initWithFrame:CGRectMake(100, 100, 8, 0)];
    lineCode.edge = UIEdgeInsetsMake(40, 0, 40, 0);
    lineCode.items = @[@"tesbbrtt",@"哈34哈",@"12dftg3",@"12cvf3",@"134523"];
    lineCode.itemWidth = 8;
    lineCode.itemMargin = 80;
    lineCode.doneColor = [UIColor colorWithRed:0.278 green:0.600 blue:0.227 alpha:1.000];
    lineCode.selectColor = [UIColor colorWithRed:0.757 green:0.000 blue:0.141 alpha:1.000];
    lineCode.normalColor = [UIColor colorWithWhite:0.480 alpha:0.600];
    lineCode.selectedIndex = 3;
    [lineCode setTouchedLineBlock:^(NSInteger index, NSString *title) {
        NSLog(@"click%zd title%@",index,title);

    }];
    [self.view addSubview:lineCode];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
