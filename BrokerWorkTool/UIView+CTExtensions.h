//
//  UIView+CTExtensions.h
//  CTRIP_WIRELESS
//
//  Created by Haoran Chen on 11/13/13.
//  Copyright (c) 2013 携程. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CTExtensions)

//以下属性setter可用
@property (nonatomic) CGFloat ctWidth;
@property (nonatomic) CGFloat ctHeight;

@property (nonatomic) CGFloat ctTop;
@property (nonatomic) CGFloat ctLeft;
@property (nonatomic) CGFloat ctRight;
@property (nonatomic) CGFloat ctBottom;

@property (nonatomic) CGSize ctSize;
@property (nonatomic) CGPoint ctOrigin;

//下面那些设置来、设置去的属性弱爆了

// 获取和设置x坐标
- (CGFloat)viewX;
- (void)setViewX:(CGFloat)xPoint;

// 获取和设置y坐标
- (CGFloat)viewY;
- (void)setViewY:(CGFloat)yPoint;

// 获取和设置width
- (CGFloat)viewWidth;
- (void)setViewWidth:(CGFloat)width;

// 获取和设置height
- (CGFloat)viewHeight;
- (void)setViewHeight:(CGFloat)height;

// 获取和设置origin
- (CGPoint)viewOrigin;
- (void)setViewOrigin:(CGPoint)origin;

// 获取和设置size
- (CGSize)viewSize;
- (void)setViewSize:(CGSize)size;

// 获取view的最右边的x值
-(CGFloat)viewXRight;
// 获取view的最下边的y值
-(CGFloat)viweYBelow;

// Sody modified at 2013.11.12
/**
 *  show the border around the view
 *
 *  @param color border color
 */
-(void) showBorderWithColor:(UIColor*)color;

/**
 *  Print the view positino information.
 */
-(void) printPositionInfo;

/**
 *	Extract a view from a xib
 *  Note: The view and class name must be the same.
 *
 *	@return	the view extracted or nil if fail
 */
+ (instancetype)extractFromXib;

/**
 *  Remove all subView
 */
- (void)removeAllSubView;

/**
 *  As its name hints.
 **/
-(void)moveRightToParentWithPadding:(CGFloat) padding;

/**
 *  As its name hints.
 **/
-(void)centerHorizontally;

/**
 *  As its name hints.
 **/
-(void)centerVertically;

/**
 *  Set up the widget accessibility label.
 *
 *  @param accessibilityLabel the label to set to widget.
 */
-(void)setupAccessibility:(NSString *)accessibilityLabel;

/**
 *  Set up the accessibility value.
 *
 *  @param value <#value description#>
 */
-(void)setupAccessibilityValue:(NSString*)value;
@end
