//
//  ViewController.m
//  SKMultiAlertViewDemo
//
//  Created by zhanghuabing on 16/9/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SKAlertView.h"
#import "SKAlertViewManager.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *oneView;

@property (strong, nonatomic) UIView *twoView;

@property (strong, nonatomic) SKAlertViewManager *alertManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _alertManager   = [[SKAlertViewManager alloc] init];
    
    _oneView = [[UIView alloc] initWithFrame:self.view.bounds];
    _oneView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_oneView];
    NSLog(@"subViews : %zi", self.view.subviews.count);
    
    UIView *oneAlerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    oneAlerView.backgroundColor = [UIColor redColor];
    [_oneView addSubview:oneAlerView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setFrame:CGRectMake(100, _oneView.frame.size.height - 100, 100, 50)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn setBackgroundColor:[UIColor orangeColor]];
    [closeBtn addTarget:self action:@selector(dismissAlertView) forControlEvents:UIControlEventTouchUpInside];
    [_oneView addSubview:closeBtn];
    
    //    [self.view sk_addAlertView:_oneView atAlertIndex:0];
    [self.view addSubview:_oneView];
    [_alertManager pushAlertView:_oneView atIndex:0];
    
    
    _twoView    = [[UIView alloc] initWithFrame:self.view.bounds];
    _twoView.backgroundColor    = [UIColor whiteColor];
    
    UIButton *closeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn1 setFrame:CGRectMake(100, _oneView.frame.size.height - 100, 100, 50)];
    [closeBtn1 setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn1 setBackgroundColor:[UIColor greenColor]];
    [closeBtn1 addTarget:self action:@selector(dismissAlertViewTwo) forControlEvents:UIControlEventTouchUpInside];
    [_twoView addSubview:closeBtn1];
    
    //    [self.view sk_addAlertView:_twoView atAlertIndex:0];
    [self.view addSubview:_twoView];
    [_alertManager pushAlertView:_twoView atIndex:0];
    
    NSString *str1 = @"str1";
    NSString *str2 = str1;
    NSString *str3 = str2;
    
    str1 = @"changed";
    
    NSLog(@"%@", str2);
    NSLog(@"%@", str3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"====== %s =======", __func__);
    
    [_alertManager refresh];
    //    [self.view sk_alertViewBringToFront];
}

- (void)dismissAlertView{
    [_oneView removeFromSuperview];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:SKNOTIFY_ALERT_DISMISS object:nil userInfo:nil];
    //    NSLog(@"oneView superView : %@", _oneView.superview);
}

- (void)dismissAlertViewTwo{
    [_twoView removeFromSuperview];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:SKNOTIFY_ALERT_DISMISS object:nil userInfo:nil];
}


@end
