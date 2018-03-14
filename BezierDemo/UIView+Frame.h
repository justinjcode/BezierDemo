//
//  UIView+Frame.h
//  BezierDemo
//
//  Created by tondy zhang on 2018/3/14.
//  Copyright © 2018年 tondy zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)maxX;
- (CGFloat)maxY;

@end
