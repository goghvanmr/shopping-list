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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    [self.delegate controller:self didSaveItemWithName:self.name.text andPrice:[self.price.text floatValue]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
