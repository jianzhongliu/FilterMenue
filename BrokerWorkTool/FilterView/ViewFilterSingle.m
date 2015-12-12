//
//  ViewFilter.m
//  BrokerWorkTool
//
//  Created by liujianzhong on 15/12/10.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "ViewFilterSingle.h"

@interface ViewFilterSingle () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIControl *controlBack;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id selectedValue;

@end

@implementation ViewFilterSingle


- (UIView *)viewBack {
    if (_viewBack == nil) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
        [_viewBack setBackgroundColor:[UIColor whiteColor]];
    }
    return _viewBack;
}

- (UIControl *)controlBack {
    if (_controlBack == nil) {
        _controlBack = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
        [_controlBack setBackgroundColor:DSColorAlphaMake(0, 0, 0, 0.5)];
        [_controlBack addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchDown];
    }
    return _controlBack;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
    }
    return _tableView;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    [self.viewBack addSubview:self.tableView];
    [self.controlBack addSubview:self.viewBack];
    [self addSubview:self.controlBack];
}

- (void)setDefaultValue:(id) value {
    [self.arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([value isEqualToString:obj]) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:scrollIndexPath];
            cell.textLabel.textColor = DSColor;
            [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
}

/**隐藏下拉框*/
- (void)onClickCancel {
    [self hidden];
    if (_delegate && [_delegate respondsToSelector:@selector(didClickCancelAction:)]) {
        [_delegate didClickCancelAction:self];
    }
}

/**显示下拉框*/
- (void)show {
        self.ctHeight = SCREENHEIGHT;
        self.controlBack.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.viewBack.frame = CGRectMake(0, 0, SCREENWIDTH, self.viewHight);
        self.tableView.frame = self.viewBack.frame;
}

- (void)hidden {
    self.ctHeight = 0;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.arrayData[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if ([self.selectedValue isEqualToString:self.arrayData[indexPath.row]]) {
        cell.textLabel.textColor = DSColor;
    } else {
        cell.textLabel.textColor = DSBlackColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = DSColor;
    self.selectedValue = self.arrayData[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItem:atIndex:withValue:)]) {
        [_delegate didSelectItem:self atIndex:indexPath.row withValue:self.arrayData[indexPath.row]];
    }
    [self.tableView reloadData];
}

@end
