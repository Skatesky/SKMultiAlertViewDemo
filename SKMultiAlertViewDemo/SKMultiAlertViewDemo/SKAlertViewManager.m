//
//  SKAlertViewManager.m
//  MultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/7.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SKAlertViewManager.h"
#import "UIView+SKAlertView.h"

@interface SKAlertViewManager ()

@property (strong, nonatomic) NSMutableArray *alertViews;

@end

@implementation SKAlertViewManager

- (NSMutableArray *)alertViews{
    if (!_alertViews) {
        _alertViews = [[NSMutableArray alloc] init];
    }
    return _alertViews;
}

- (void)pushAlertView:(UIView *)alertView atIndex:(NSInteger)index{
    alertView.sk_alertIndex = index;
    alertView.hidden    = YES;
    //先隐藏顶部视图
    NSInteger showIndex = [self topViewIndex];
    if (showIndex >= 0) {
        UIView *showView    = self.alertViews[showIndex];
        showView.hidden     = YES;
    }
    //寻找合适的地方插入新的视图
    if (!_alertViews || index < 0) {
        [self.alertViews addObject:alertView];
    } else {
        NSInteger currentIndex = [self searchIndexForViewAlertIndex:index];
        if (currentIndex >= self.alertViews.count) {
            [self.alertViews addObject:alertView];
        } else {
            [self.alertViews insertObject:alertView atIndex:index];
        }
    }
    
    [self refresh];
}

- (void)popAlertView:(UIView *)alertView{
    
}

- (void)refresh{
    //显示顶部视图，可去掉动画
    NSInteger showIndex = [self topViewIndex];
    UIView *showView    = self.alertViews[showIndex];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        showView.hidden     = NO;
    } completion:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = 0.3;
    [showView.layer addAnimation:animation forKey:@"bouce"];
    
    if (showIndex < self.alertViews.count - 1) {
        //        [self.alertViews removeObjectsInRange:NSMakeRange(showIndex + 1, self.alertViews.count - showIndex - 1)];
        [self.alertViews removeLastObject];
    }
}

#pragma mark - private methods
- (NSInteger)searchIndexForViewAlertIndex:(NSInteger)alertIndex{
    NSInteger searchIndex = 0;
    while (searchIndex < self.alertViews.count) {
        UIView *aView = self.alertViews[searchIndex];
        if (aView.sk_alertIndex > alertIndex) {
            break;
        } else {
            searchIndex++;
        }
    }
    return searchIndex;
}

- (NSInteger)topViewIndex{
    NSInteger index = self.alertViews.count - 1;
    for (; index > 0; index--) {
        UIView *aView = self.alertViews[index];
        if (aView && aView.superview) {
            break;
        }
    }
    return index;
}

@end
