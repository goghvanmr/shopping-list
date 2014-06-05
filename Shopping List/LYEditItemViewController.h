//
//  LYEditItemViewController.h
//  Shopping List
//
//  Created by LI Yi on 6/5/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYItem.h"

@interface LYEditItemViewController : UIViewController

@property (nonatomic, strong)IBOutlet UITextField *name;
@property (nonatomic, strong)IBOutlet UITextField *price;

@property (nonatomic, strong)LYItem *item;

@end
