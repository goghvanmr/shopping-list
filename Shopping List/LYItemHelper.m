//
//  LYItemHelper.m
//  Shopping List
//
//  Created by LI Yi on 6/7/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYItemHelper.h"

#import "LYItem.h"

@implementation LYItemHelper

+ (NSArray *)loadItemsFromFile {
    NSString *filePath = [self pathForItems];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        return [NSArray array];
    }
    
}

+ (void)saveItems:(NSArray *)items {
    NSString *filePath = [LYItemHelper pathForItems];
    [NSKeyedArchiver archiveRootObject:items toFile:filePath];
}

#pragma mark - Private Method

+ (NSString *)pathForItems {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    
    return [documents stringByAppendingPathComponent:@"items.plist"];
}

@end
