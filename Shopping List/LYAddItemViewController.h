//
//  LYAddItemViewController.h
//  Shopping List
//
//  Created by LI Yi on 6/2/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYAddItemViewControllerDelegate;

@interface LYAddItemViewController : UIViewController

@property (nonatomic, weak) id<LYAddItemViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UITextField *name;

@end


@protocol LYAddItemViewControllerDelegate <NSObject>

- (void)controller:(LYAddItemViewController *)controller didSaveItemWithName:(NSString *)name;

@end
