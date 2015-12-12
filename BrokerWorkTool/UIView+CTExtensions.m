//
//  UIView+CTExtensions.m
//  CTRIP_WIRELESS
//
//  Created by Haoran Chen on 11/13/13.
//  Copyright (c) 2013 携程. All rights reserved.
//

#import "UIView+CTExtensions.h"

@implementation UIView (CTExtensions)


- (void) setCtHeight:(CGFloat)ctHeight
{
    CGRect frame = self.frame;
    frame.size.height = ctHeight;
    self.frame = frame;
}
- (void) setCtWidth:(CGFloat)ctWidth {
    CGRect frame = self.frame;
    frame.size.width = ctWidth;
    self.frame = frame;
}

- (void) setCtLeft:(CGFloat)ctLeft
{
    CGRect frame = self.frame;
    frame.origin.x = ctLeft;
    self.frame = frame;
}

- (void) setCtRight:(CGFloat)ctRight {
    CGRect frame = self.frame;
    frame.origin.x = ctRight - frame.size.width ;
    self.frame = frame;
}

- (void) setCtBottom:(CGFloat)ctBottom {
    CGRect frame = self.frame;
    frame.origin.y = ctBottom - frame.size.height ;
    self.frame = frame;
}

- (void) setCtTop:(CGFloat)ctTop {
    CGRect frame = self.frame;
    frame.origin.y = ctTop;
    self.frame = frame;
}
- (void) setCtSize:(CGSize)ctSize {
    CGRect frame = self.frame;
    frame.size = ctSize;
    self.frame = frame;
}
- (void) setCtOrigin:(CGPoint)ctOrigin {
    CGRect frame = self.frame;
    frame.origin = ctOrigin;
    self.frame = frame;
}
- (CGFloat) ctLeft { return self.frame.origin.x; }
- (CGFloat) ctTop { return self.frame.origin.y; }
- (CGFloat) ctHeight { return self.frame.size.height; }
- (CGFloat) ctWidth { return self.frame.size.width; }
- (CGSize) ctSize { return self.frame.size;}
- (CGPoint) ctOrigin { return self.frame.origin;}

- (CGFloat) ctRight { return self.frame.origin.x + self.frame.size.width; }
- (CGFloat) ctBottom { return self.frame.origin.y + self.frame.size.height; }

// 获取和设置x坐标
- (CGFloat)viewX
{
	CGRect frame = self.frame;
	return frame.origin.x;
}

- (void)setViewX:(CGFloat)xPoint
{
	CGRect frame = self.frame;
	frame.origin.x = xPoint;
	self.frame = frame;
}

// 获取和设置y坐标
- (CGFloat)viewY
{
	CGRect frame = self.frame;
	return frame.origin.y;
}

- (void)setViewY:(CGFloat)yPoint
{
	CGRect frame = self.frame;
	frame.origin.y = yPoint;
	self.frame = frame;
}

// 获取和设置width
- (CGFloat)viewWidth
{
	CGRect frame = self.frame;
	return frame.size.width;
}

- (void)setViewWidth:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

// 获取和设置height
- (CGFloat)viewHeight
{
	CGRect frame = self.frame;
	return frame.size.height;
}

- (void)setViewHeight:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

// 获取和设置origin
- (CGPoint)viewOrigin
{
	CGRect frame = self.frame;
	return frame.origin;
}

- (void)setViewOrigin:(CGPoint)origin
{
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

// 获取和设置size
- (CGSize)viewSize
{
	CGRect frame = self.frame;
	return frame.size;
}

- (void)setViewSize:(CGSize)size
{
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

// 获取view的最右边的x值
-(CGFloat)viewXRight
{
	CGRect frame = self.frame;
	return frame.origin.x + frame.size.width;
}

// 获取view的最下边的y值
-(CGFloat)viweYBelow
{
	CGRect frame = self.frame;
	return frame.origin.y + frame.size.height;
}

-(void) showBorderWithColor:(UIColor*)color{
#ifdef DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = color.CGColor;
#endif
}

-(void) printPositionInfo{
//    CGRect myFrame = self.frame;
}

+ (instancetype)extractFromXib
{
    NSString* viewName = NSStringFromClass([self class]);
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:viewName owner:nil options:nil];
    Class   targetClass = NSClassFromString(viewName);
    
    for (UIView *view in views) {
        if ([view isMemberOfClass:targetClass]) {
            return view;
        }
    }
    
    return nil;
}

-(void)removeAllSubView
{
	NSArray *arraySubView = [NSArray arrayWithArray:self.subviews];
	for(UIView *subView in arraySubView)
	{
		if(subView.subviews.count != 0)
		{
			[subView removeAllSubView];
		}
		[subView removeFromSuperview];
	}
}

-(void)moveRightToParentWithPadding:(CGFloat) padding{
    if (self.superview == nil) {
        return;
    }

    CGRect myFrame = self.frame;
    myFrame.origin.x = self.superview.frame.size.width - myFrame.size.width - padding;

    self.frame = myFrame;
}

-(void)centerVertically{
    if (self.superview == nil) {
        return;
    }

    CGRect myFrame = self.frame;
    myFrame.origin.y = (self.superview.frame.size.height - myFrame.size.height)/2;
    self.frame = myFrame;
}

-(void)centerHorizontally{
    if (self.superview == nil) {
        return;
    }

    CGRect myFrame = self.frame;
    myFrame.origin.x = (self.superview.frame.size.width - myFrame.size.width)/2;
    self.frame = myFrame;
}

-(void)setupAccessibility:(NSString *)accessibilityLabel{
#ifdef InDev
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        self.accessibilityIdentifier = accessibilityLabel;
       // TLog(@"Accessibility: %@", accessibilityLabel);
    }
#endif
}

-(void)setupAccessibilityValue:(NSString*)value{
#ifdef InDev
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0){
        self.accessibilityValue = value;
    }
#endif
}
@end
