//
//  AppDelegate.m
//  RichQuantify
//
//  Created by 岳万里 on 2017/9/11.
//  Copyright © 2017年 岳万里. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBC.h"
#import "BaseNC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseTabBC *baseBC = [[BaseTabBC alloc] init];
    self.window.rootViewController = baseBC;
    [self.window makeKeyAndVisible];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self monitorNet];

    return YES;
}

#pragma mark --- 网络监测
- (void)monitorNet
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown)
        {
            //未知网络
            [self noticeNetWithMessage:@"当前网络环境：未知网络"];
        }
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            //网络无连接的提示
            [self noticeNetWithMessage:@"当前网络环境：未连接到网络"];
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            //当前使用数据流量
            [self noticeNetWithMessage:@"当前网络环境：数据流量"];
        }
        if (status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            //当前网络环境为WiFi
            [self noticeNetWithMessage:@"当前网络环境：WiFi"];
        }
    }];
}

#pragma mark --- 提示网络状态
- (void)noticeNetWithMessage:(NSString *) message
{
    [MBProgressHUD hideAllHUDsForView:self.window animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.labelText = message;
    [hud hide:YES afterDelay:1.0f];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
