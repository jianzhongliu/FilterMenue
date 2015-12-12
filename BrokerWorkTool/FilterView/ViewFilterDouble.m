//
//  ViewFilter.m
//  BrokerWorkTool
//
//  Created by liujianzhong on 15/12/10.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "ViewFilterDouble.h"

@interface ViewFilterDouble () <UITableViewDataSource, UITableViewDelegate>
{
    UITableViewCell *selectedMainCell;//单选所以就只留一个cell，以后改多选了，就是一个数组
    UITableViewCell *selectedSubCell;
}
@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIControl *controlBack;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableViewSub;
@property (nonatomic, strong) NSString *selectedMain;
@property (nonatomic, strong) NSString *selectedSub;

@end

@implementation ViewFilterDouble

- (void)setDicData:(NSMutableDictionary *)dicData {
    [_dicData removeAllObjects];
    if (_dicData == nil) {
        _dicData = [NSMutableDictionary dictionary];
        return;
    }
    [_dicData setValuesForKeysWithDictionary:dicData];
    [self.arrayDataMain removeAllObjects];
    [self.arrayDataMain addObjectsFromArray:[_dicData allKeys]];
}

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
        [_controlBack setBackgroundColor:DSColorFromHex(0xf7f7f7)];
        [_controlBack addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchDown];
    }
    return _controlBack;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = FILTERMAINTAG;
//        _tableView.separatorColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSColorFromHex(0xf1f1f1);
    }
    return _tableView;
}

- (UITableView *)tableViewSub {
    if (_tableViewSub == nil) {
        _tableViewSub = [[UITableView alloc] init];
        _tableViewSub.delegate = self;
        _tableViewSub.tag = FILTERSUBTAG;
        _tableViewSub.dataSource = self;
//        _tableViewSub.separatorColor = [UIColor clearColor];
//        _tableViewSub.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViewSub.backgroundColor = [UIColor whiteColor];
    }
    return _tableViewSub;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        self.dicData = [NSMutableDictionary dictionary];
        self.arrayDataMain = [NSMutableArray array];
        self.arrayDataSub = [NSMutableArray array];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    [self.viewBack addSubview:self.tableView];
    [self.viewBack addSubview:self.tableViewSub];
    [self.controlBack addSubview:self.viewBack];
    [self addSubview:self.controlBack];
}

- (void)setDefaultValue:(id) value {
    NSString *main = value[@"main"];
    NSString *sub = value[@"sub"];
    [self.arrayDataMain enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([main isEqualToString:obj]) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:scrollIndexPath];
            cell.textLabel.textColor = DSColor;
            [self.tableView selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            //刷新子列表数据
            [self.arrayDataSub removeAllObjects];
            [self.arrayDataSub addObjectsFromArray:self.dicData[self.arrayDataMain[idx]]];
            [self.tableViewSub reloadData];
        }
    }];
    
    [self.arrayDataSub enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([sub isEqualToString:obj]) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];

            UITableViewCell *cell = [self.tableViewSub cellForRowAtIndexPath:scrollIndexPath];
            cell.textLabel.textColor = DSColor;
            [self.tableViewSub scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    selectedMainCell.textLabel.textColor = DSBlackColor;
}

- (void)showSubList {
    self.tableViewSub.frame = CGRectMake(SCREENWIDTH / 2, self.tableView.ctTop, SCREENWIDTH / 2,self.viewBack.ctHeight);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == FILTERMAINTAG) {
        return self.arrayDataMain.count;
    }else {
        return self.arrayDataSub.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (tableView.tag == FILTERMAINTAG) {
        cell.textLabel.text = self.arrayDataMain[indexPath.row];
        if ([self.selectedMain isEqualToString:cell.textLabel.text]) {
            cell.textLabel.textColor = DSColor;
        }else {
            cell.textLabel.textColor = DSBlackColor;
        }
    } else {
        cell.textLabel.text = self.arrayDataSub[indexPath.row];
        if ([self.selectedSub isEqualToString:cell.textLabel.text]) {
            cell.textLabel.textColor = DSColor;
        }else {
            cell.textLabel.textColor = DSBlackColor;
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView.tag == FILTERMAINTAG) {
        if ([self.selectedMain isEqualToString:self.arrayDataMain[indexPath.row]]) {
            selectedSubCell = [[UITableViewCell alloc] init];
        }
        selectedMainCell.textLabel.textColor = DSBlackColor;
        selectedMainCell = cell;
        selectedMainCell.textLabel.textColor = DSColor;
        self.selectedMain = self.arrayDataMain[indexPath.row];
        [self.arrayDataSub removeAllObjects];
        [self.arrayDataSub addObjectsFromArray:self.dicData[self.arrayDataMain[indexPath.row]]];
        [self.tableViewSub reloadData];
        [self showSubList];
        if ([self.dicData[self.arrayDataMain[indexPath.row]] count] == 0) {//当主列表选中项没有子列表时直接返回主列表title
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectItem:atIndex:withValue:)]) {
                [_delegate didSelectItem:self atIndex:indexPath.row withValue:@{@"main":self.selectedMain,@"sub":@""}];
            }
        }
        [tableView reloadData];
    } else {
        selectedSubCell.textLabel.textColor = DSBlackColor;
        selectedSubCell = cell;
        cell.textLabel.textColor = DSColor;
        self.selectedSub = self.arrayDataSub[indexPath.row];
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectItem:atIndex:withValue:)]) {
            [_delegate didSelectItem:self atIndex:indexPath.row withValue:@{@"main":self.selectedMain,@"sub":self.selectedSub}];
        }
    }
}

@end
