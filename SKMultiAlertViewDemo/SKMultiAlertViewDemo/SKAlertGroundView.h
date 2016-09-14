//
//  SKAlertGroundView.h
//  MultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

/////////////////////////////////////////////////////////////////////////////////////////////
#if TARGET_IPHONE_SIMULATOR
#define JMLog( s, ... ) NSLog( @"[%@:%d] %@", [[NSString stringWithUTF8String:__FILE__] \
lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define JMLog( s, ... )
#endif
/////////////////////////////////////////////////////////////////////////////////////////////

#define SKNOTIFY_ALERT_DISMISS    @"SKNotify_Alert_Dismiss"

NS_ASSUME_NONNULL_BEGIN
/**
 *  所有弹出框展示的基础图层
 *  1.在没有弹出层的时候自动隐藏或释放
 */
@interface SKAlertGroundView : UIView

@property (copy, nonatomic) void (^allAlertRemoveBlk)();

- (void)addAlertView:(UIView *)alertView;

/**
 *  加入某个弹框到弹框层中
 *  @param alertView 弹框
 *  @param index     弹框的层级，值越高，层级越大
 */
- (void)addAlertView:(UIView *)alertView index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END