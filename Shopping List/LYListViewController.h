//
//  LYListViewController.h
//  Shopping List
//
//  Created by LI Yi on 6/1/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYAddItemViewController.h"
#import "LYEditItemViewController.h"

@interface LYListViewController : UITableViewController
<LYAddItemViewControllerDelegate, LYEditItemViewControllerDelegate>

@end
