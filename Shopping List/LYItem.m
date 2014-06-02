//
//  LYItem.m
//  Shopping List
//
//  Created by LI Yi on 6/1/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYItem.h"

@implementation LYItem

+ (LYItem *)createItemWithName:(NSString *)name andPrice:(float) price {
    LYItem *item = [[LYItem alloc]init];
    
    item.uuid = [[NSUUID UUID]UUIDString];
    item.name = name;
    item.price = price;
    item.inShoppingList = NO;
    
    return item;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeFloat:self.price forKey:@"price"];
    [aCoder encodeBool:self.inShoppingList forKey:@"inShoppingList"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        [self setUuid:[aDecoder decodeObjectForKey:@"uuid"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setPrice:[aDecoder decodeFloatForKey:@"price"]];
        [self setInShoppingList:[aDecoder decodeBoolForKey:@"inShoppingList"]];
    }
    
    return self;
}

@end
