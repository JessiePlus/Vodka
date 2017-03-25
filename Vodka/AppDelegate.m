//
//  AppDelegate.m
//  Vodka
//
//  Created by dinglin on 2017/3/4.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <WeexSDK/WeexSDK.h>

#import "AppDelegate.h"
#import "GoodsCategoriesViewController.h"
#import "UserCenterViewController.h"
#import "DiscoverViewController.h"
#import "DLFeedsViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //business configuration
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    //init sdk enviroment
    [WXSDKEngine initSDKEnviroment];
    
    
    
    //register custom module and component，optional
    //[WXSDKEngine registerComponent:@"MyView" withClass:[MyViewComponent class]];
    //[WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];
    //register the implementation of protocol, optional
    //[WXSDKEngine registerHandler:[WXNavigationDefaultImpl new] withProtocol:@protocol(WXNavigationProtocol)];
    
    
    //set the log level
    [WXLog setLogLevel: WXLogLevelAll];
    
    
    GoodsCategoriesViewController *goodsCategoriesViewController = [[GoodsCategoriesViewController alloc] init];
    goodsCategoriesViewController.tabBarItem.title = NSLocalizedString(@"Goods", comment: "");
    goodsCategoriesViewController.tabBarItem.image = [UIImage imageNamed:@"icon_drinks"];
    goodsCategoriesViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_drinks_active"];
    
    UINavigationController *navGoodsCategoriesController = [[UINavigationController alloc] initWithRootViewController:goodsCategoriesViewController];

    DLFeedsViewController *feedsViewController = [[DLFeedsViewController alloc] init];
    feedsViewController.tabBarItem.title = NSLocalizedString(@"Feeds", comment: "");
    feedsViewController.tabBarItem.image = [UIImage imageNamed:@"icon_feeds"];
    feedsViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_feeds_active"];
    
    UINavigationController *navFeedsController = [[UINavigationController alloc] initWithRootViewController:feedsViewController];


    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] init];
    discoverViewController.tabBarItem.title = NSLocalizedString(@"Discover", comment: "");
    discoverViewController.tabBarItem.image = [UIImage imageNamed:@"icon_explore"];
    discoverViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_explore_active"];
    
    UserCenterViewController *userCenterViewController = [[UserCenterViewController alloc] init];
    userCenterViewController.tabBarItem.title = NSLocalizedString(@"Me", comment: "");
    userCenterViewController.tabBarItem.image = [UIImage imageNamed:@"icon_me"];
    userCenterViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_me_active"];
    
    UINavigationController *navUserCenterController = [[UINavigationController alloc] initWithRootViewController:userCenterViewController];

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:navGoodsCategoriesController, navFeedsController, discoverViewController, navUserCenterController, nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    
    
    return YES;
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
