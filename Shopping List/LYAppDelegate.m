//
//  LYAppDelegate.m
//  Shopping List
//
//  Created by LI Yi on 6/1/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYAppDelegate.h"

#import "LYItem.h"

@implementation LYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [self seedItems];
    return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self seedItems];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods

- (void)seedItems {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (![ud boolForKey:@"LYUserDefaultsSeedItems"]) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"seed" ofType:@"plist"];
        NSArray *seedItems = [NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray *items = [NSMutableArray array];
        
        for (int i = 0; i < [seedItems count]; i++) {
            NSDictionary *seedItem = [seedItems objectAtIndex:i];
            
            LYItem *item = [LYItem createItemWithName:[seedItem objectForKey:@"name"]
                                             andPrice:[[seedItem objectForKey:@"price"]floatValue]];
            
            [items addObject:item];
        }
        
        NSLog(@"Seed Item Count -> %lu", (unsigned long)[items count]);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths lastObject];
        NSString *itemsPath = [documents stringByAppendingPathComponent:@"items.plist"];
        
        if ([NSKeyedArchiver archiveRootObject:items toFile:itemsPath]) {
            [ud setBool:YES forKey:@"LYUserDefaultsSeedItems"];
        }
    }
}

@end
