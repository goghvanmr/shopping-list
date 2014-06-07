//
//  LYItem.h
//  Shopping List
//
//  Created by LI Yi on 6/1/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYItem : NSObject <NSCoding>

@property (nonatomic, strong)NSString *uuid;
@property (nonatomic, strong)NSString *name;
@property (nonatomic)BOOL inShoppingList;

+ (LYItem *)createItemWithName:(NSString *)name;

@end
