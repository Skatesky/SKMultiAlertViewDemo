//
//  UIView+SKAlertView.h
//  MultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKAlertGroundView.h"
#import "SKAlertViewManager.h"

/**
 *  通过分类方法类管理弹出框
 */
@interface UIView (SKAlertView)

@property (assign, nonatomic) NSInteger sk_alertIndex;

@property (strong, nonatomic) SKAlertGroundView *sk_alertBaseView;

@property (strong, nonatomic) SKAlertViewManager *sk_alertManager;

#pragma mark - solution 1
- (void)sk_addAlertView:(UIView *)view atAlertIndex:(NSInteger)index;

- (void)sk_alertViewBringToFront;

#pragma mark - solution 2
- (void)sk_pushAlertView:(UIView *)view atAlertIndex:(NSInteger)alertIndex;

- (void)sk_popAlertView:(UIView *)view;

- (void)sk_refreshAlertViews;

#pragma mark - soulution 3
// 通过单例的形式进行弹框的管理，而不是属性，这样便能跨父视图进行不同父视图上的弹框管理


@end
