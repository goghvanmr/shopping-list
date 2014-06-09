//
//  LYShoppingListViewController.h
//  Shopping List
//
//  Created by LI Yi on 6/6/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYItem.h"
#import "LYItemHelper.h"

@interface LYShoppingListViewController : UITableViewController

@property (nonatomic, strong)NSArray *shoppingList;
@property (nonatomic, weak)NSArray *items;

@end
