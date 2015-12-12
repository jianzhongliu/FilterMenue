//
//  HomeViewController.m
//  BrokerWorkTool
//
//  Created by liujianzhong on 15/12/10.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "HomeViewController.h"
#import "DSConfig.h"
#import "ViewFilterSingle.h"
#import "ViewFilterDouble.h"
#import "FilterViewTool.h"

@interface HomeViewController ()

@property (nonatomic, strong) FilterViewTool *viewFilter;

@end

@implementation HomeViewController
- (FilterViewTool *)viewFilter {
    if (_viewFilter == nil) {
        _viewFilter = [[FilterViewTool alloc] init];
//        _viewFilter.backgroundColor = DSColor;
    }
    return _viewFilter;
}

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.view setBackgroundColor:DSBackColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(100, 0, 60, 30);
    [button addTarget:self action:@selector(onShowFilter) forControlEvents:UIControlEventTouchDown];
    [button setBackgroundColor:DSColor];
    [self.view addSubview:button];
    
    UIButton *buttonDouble = [UIButton buttonWithType:UIButtonTypeContactAdd];
    buttonDouble.frame = CGRectMake(200, 0, 60, 30);
    [buttonDouble addTarget:self action:@selector(onShowFilterDouble) forControlEvents:UIControlEventTouchDown];
    [buttonDouble setBackgroundColor:DSColor];
    [self.view addSubview:buttonDouble];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewFilter.frame = CGRectMake(0, 0, SCREENWIDTH , 40);
    
}

- (void)initData {
    
}

- (void)initUI {
    [self setTitle:@""];
    [self.view addSubview:self.viewFilter];
}

@end
