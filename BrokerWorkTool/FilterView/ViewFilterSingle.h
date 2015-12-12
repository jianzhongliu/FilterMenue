//
//  ViewFilter.h
//  BrokerWorkTool
//
//  Created by liujianzhong on 15/12/10.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSConfig.h"
#import "UIView+CTExtensions.h"

@class ViewFilterSingle;
@protocol ViewFilterSingleDelegate <NSObject>

- (void)didClickCancelAction:(id) filter;
- (void)didSelectItem:(id) filter atIndex:(NSInteger ) index withValue:(id) value;

@end

@interface ViewFilterSingle : UIView

@property (nonatomic,assign) CGFloat viewHight;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSMutableDictionary *dicData;
@property (nonatomic, assign) id<ViewFilterSingleDelegate> delegate;

- (void)setDefaultValue:(id) value;

- (void)show;

- (void)hidden;

@end
