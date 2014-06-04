//
//  LYListViewController.m
//  Shopping List
//
//  Created by LI Yi on 6/1/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYListViewController.h"

#import "LYItem.h"

@interface LYListViewController ()

@property NSMutableArray *items;

@end

@implementation LYListViewController

static NSString *CellIdentifier = @"Cell Identifier";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(addItem:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.title = @"Items";
        [self loadItems];
    }
    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LYItem *item = [self.items objectAtIndex:[indexPath row]];
    cell.textLabel.text = item.name;
    
    return cell;
}

#pragma  mark - Private Methods

- (void)saveItems {
    NSString *filePath = [self pathForItems];
    [NSKeyedArchiver archiveRootObject:self.items toFile:filePath];
}

- (void)loadItems {
    NSString *filePath = [self pathForItems];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        self.items = [NSMutableArray array];
    }
}

- (NSString *)pathForItems {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    
    return [documents stringByAppendingPathComponent:@"items.plist"];
}

- (void)addItem:(id)sender {
    // Do Nothing
    NSLog(@"Add button tapper");
    [self performSegueWithIdentifier:@"add_item_from_list" sender:self];
}

@end
