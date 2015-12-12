//
//  ViewFilter.h
//  BrokerWorkTool
//
//  Created by liujianzhong on 15/12/10.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//
/**
 需求：
 1，选项分两列，点第一列第二页内容需要变更
 *****实现****
 点击第一项后清空第二列数据，然后从数据源取第二列数据，然后reload列表
 2，默认展开时若之前已经选取了内容，需要高亮显示之前选中的内容，
 *****实现****
 首先分主列表和子列表，然后遍历主列表找到上次选中的内容对应行然后高亮，接着要remove下子列表的内容并从数据源取子列表的内容，最后遍历子列表找到上次记录的选项设置高亮。
 3,列表只能单选，选择第二个选项时上一个选中状态置灰
 *****实现****
 reloadtable，把当前选中项置高亮
 4,点击更多或者列表下面灰色部分或者子列表要消失当前选择框
  *****实现****
 执行对应的点击事件就行了，把父viewFrame高度设置为0，这里需要注意clipstobounds的设置

 */
 
#import <UIKit/UIKit.h>
#import "DSConfig.h"
#import "UIView+CTExtensions.h"

#define FILTERMAINTAG 300
#define FILTERSUBTAG 301

@class ViewFilterDouble;

@protocol ViewFilterDoubleDelegate <NSObject>

- (void)didClickCancelAction:(id) filter;
- (void)didSelectItem:(id) filter atIndex:(NSInteger ) index withValue:(id) value;

@end

@interface ViewFilterDouble : UIView
@property (nonatomic,assign) CGFloat viewHight;
@property (nonatomic, strong) NSMutableArray *arrayDataMain;
@property (nonatomic, strong) NSMutableArray *arrayDataSub;

@property (nonatomic, strong) NSMutableDictionary *dicData;
@property (nonatomic, strong) id<ViewFilterDoubleDelegate> delegate;

- (void)setDefaultValue:(id) value;

- (void)show;

- (void)hidden;

@end
