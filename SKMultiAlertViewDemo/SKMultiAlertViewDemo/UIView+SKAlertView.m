//
//  UIView+SKAlertView.m
//  MultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "UIView+SKAlertView.h"
#import <objc/runtime.h>

@implementation UIView (SKAlertView)

- (NSInteger)sk_alertIndex{
    NSNumber *value = objc_getAssociatedObject(self, @selector(sk_alertIndex));
    return [value integerValue];
}

- (void)setSk_alertIndex:(NSInteger)sk_alertIndex{
    objc_setAssociatedObject(self, @selector(sk_alertIndex), [NSNumber numberWithInteger:sk_alertIndex], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SKAlertGroundView *)sk_alertBaseView{
    return objc_getAssociatedObject(self, @selector(sk_alertBaseView));
}

- (void)setSk_alertBaseView:(SKAlertGroundView *)alertBaseView{
//    [self willChangeValueForKey:NSStringFromSelector(@selector(sk_alertBaseView))];
    objc_setAssociatedObject(self, @selector(sk_alertBaseView), alertBaseView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self didChangeValueForKey:NSStringFromSelector(@selector(sk_alertBaseView))];
}

- (SKAlertViewManager *)sk_alertManager{
    return objc_getAssociatedObject(self, @selector(sk_alertManager));
}

- (void)setSk_alertManager:(SKAlertViewManager *)sk_alertManager{
    objc_setAssociatedObject(self, @selector(sk_alertManager), sk_alertManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - solution 1
- (void)sk_addAlertView:(UIView *)view atAlertIndex:(NSInteger)index{
    __weak typeof(self) weakSelf    = self;
    if (!self.sk_alertBaseView) {
        self.sk_alertBaseView   = [[SKAlertGroundView alloc] initWithFrame:self.bounds];
        self.sk_alertBaseView.allAlertRemoveBlk = ^{
            [weakSelf.sk_alertBaseView removeFromSuperview];
            weakSelf.sk_alertBaseView   = nil;
        };
        [self addSubview:self.sk_alertBaseView];
    }
    [self.sk_alertBaseView addAlertView:view index:index];
}

- (void)sk_alertViewBringToFront{
    if (self.sk_alertBaseView) {
        [self bringSubviewToFront:self.sk_alertBaseView];
    }
}

#pragma mark - solution 2
- (void)sk_pushAlertView:(UIView *)view atAlertIndex:(NSInteger)alertIndex{
    if (!self.sk_alertManager) {
        self.sk_alertManager    = [[SKAlertViewManager alloc] init];
    }
    [self.sk_alertManager pushAlertView:view atIndex:alertIndex];
}

- (void)sk_popAlertView:(UIView *)view{
    if (self.sk_alertManager) {
        [self.sk_alertManager popAlertView:view];
    }
}

- (void)sk_refreshAlertViews{
    if (self.sk_alertManager) {
        [self.sk_alertManager refresh];
    }
}

@end
