//
//  SKAlertGroundView.m
//  MultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SKAlertGroundView.h"
#import "UIView+SKAlertView.h"

@interface SKAlertGroundView ()

@property (strong, nonatomic) UIView *currentAlertView;     //当前正在显示的弹出层

@end

@implementation SKAlertGroundView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasAlertViewRemoved) name:SKNOTIFY_ALERT_DISMISS object:nil];
    }
    return self;
}

- (void)addAlertView:(UIView *)alertView{
    [self addAlertView:alertView index:-1];
}

- (void)addAlertView:(UIView *)alertView index:(NSInteger)index{
    //index 的处理
    alertView.sk_alertIndex = index;
    //可以通过二分查找法
    if (index < 0 || !self.subviews) {  //没有子视图
        [self addSubview:alertView];
    } else {
        NSInteger currentIndex = [self searchSubViewIndexForAlertIndex:index];
        if (currentIndex >= self.subviews.count) {  //超过的最高的子视图
            [self addSubview:alertView];
        } else {
            [self insertSubview:alertView atIndex:currentIndex];
        }
    }
    //监测弹出框的移除
//    [alertView addObserver:self forKeyPath:NSStringFromSelector(@selector(superview)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior  context:nil];
//    
    //先隐藏
    alertView.hidden        = YES;
    if (_currentAlertView) {    //如果不存在，则隐藏所有，并设当前的为currentAlertView
        _currentAlertView.hidden    = YES;
    }
    _currentAlertView           = [self alertTopView];
    _currentAlertView.hidden    = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"====== %s ========", __func__);
    [self hasAlertViewRemoved];
}

//- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
//    [self hasAlertViewRemoved];
//}

- (void)hasAlertViewRemoved{
    JMLog(@"有弹出框被移除");
    if (_currentAlertView && _currentAlertView.superview) {
        JMLog(@"没有移除或移除的不是最上面显示的弹窗");
    } else {
        _currentAlertView = [self alertTopView];
        _currentAlertView.hidden    = NO;
    }
    if (!_currentAlertView) {   //如果没有弹框，则移除本身，回调
        if (_allAlertRemoveBlk) {
            _allAlertRemoveBlk();
        }
        JMLog(@"如果没有弹框，则移除本身");
    }
}

- (UIView *)alertTopView{
    return [self.subviews lastObject];
}

//查找合适的位置插入
- (NSInteger)searchSubViewIndexForAlertIndex:(NSInteger)alertIndex{
    NSInteger index = 0;
    while (index < self.subviews.count) {
        UIView *aview = self.subviews[index];
        if (aview.sk_alertIndex > alertIndex) {
            break;
        } else {
            index++;
        }
    }
    return index;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SKNOTIFY_ALERT_DISMISS object:nil];
    JMLog(@"========== %s ===========", __func__);
}

@end
