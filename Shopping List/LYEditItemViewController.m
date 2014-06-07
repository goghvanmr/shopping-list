//
//  LYEditItemViewController.m
//  Shopping List
//
//  Created by LI Yi on 6/5/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYEditItemViewController.h"

@interface LYEditItemViewController ()

@end

@implementation LYEditItemViewController

@synthesize name = _name;
@synthesize item = _item;

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
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                 target:self
                                                 action:@selector(didSave:)];
    
    if (self.item) {
        self.name.text = self.item.name;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Private Methods

- (void)didSave:(id)sender {
    self.item.name = self.name.text;
    
    [self.delegate controller:self didUpdateItem:self.item];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
