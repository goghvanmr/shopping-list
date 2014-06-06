//
//  LYAddItemViewController.m
//  Shopping List
//
//  Created by LI Yi on 6/2/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYAddItemViewController.h"

@interface LYAddItemViewController ()

@end

@implementation LYAddItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    [self.delegate controller:self didSaveItemWithName:self.name.text andPrice:[self.price.text floatValue]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
