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
    [self seedItems];
    return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
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
            
            LYItem *item = [LYItem createItemWithName:[seedItem objectForKey:@"name"]];
            
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
