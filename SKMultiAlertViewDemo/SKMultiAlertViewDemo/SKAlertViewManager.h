//
//  SKAlertViewManager.h
//  MultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/7.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKAlertViewManager : NSObject

- (void)pushAlertView:(UIView *)alertView atIndex:(NSInteger)index;

- (void)popAlertView:(UIView *)alertView;

- (void)refresh;

@end

NS_ASSUME_NONNULL_END