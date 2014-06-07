//
//  LYEditItemViewController.h
//  Shopping List
//
//  Created by LI Yi on 6/5/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYItem.h"

@protocol LYEditItemViewControllerDelegate;

@interface LYEditItemViewController : UIViewController

@property (nonatomic, strong)IBOutlet UITextField *name;

@property (nonatomic, weak)id<LYEditItemViewControllerDelegate> delegate;

@property (nonatomic, strong)LYItem *item;

@end

@protocol LYEditItemViewControllerDelegate <NSObject>

- (void)controller:(UIViewController *)controller didUpdateItem:(LYItem *)item;

@end