//
//  LYItemHelper.h
//  Shopping List
//
//  Created by LI Yi on 6/7/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYItemHelper : NSObject

+ (NSArray *)loadItemsFromFile;
+ (void)saveItems:(NSArray *)items;

@end
