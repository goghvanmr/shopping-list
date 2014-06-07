//
//  LYShoppingListViewController.m
//  Shopping List
//
//  Created by LI Yi on 6/6/14.
//  Copyright (c) 2014 Flaneur. All rights reserved.
//

#import "LYShoppingListViewController.h"

@interface LYShoppingListViewController ()

@end

@implementation LYShoppingListViewController

static NSString *CellIdentifier = @"Cell Identifier";

@synthesize items = _items;
@synthesize allItems = _allItems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.title = @"Shopping List";
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(updateShoppingList:)
                                                    name:@"ShoppingListDidChangeNotification"
                                                  object:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.allItems = [LYItemHelper loadItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

#pragma mark - Setters and Getters

- (void)setAllItems:(NSArray *)items {
    if (_allItems != items) {
        _allItems = items;
        
        [self buildShoppingList];
    }
}

- (void)setItems:(NSArray *)items {
    if (_items != items) {
        _items = items;
        
        [self.tableView reloadData];
    }
}

#pragma mark - Private Methods

- (void)buildShoppingList {
    NSMutableArray *buffer = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [self.allItems count]; i++) {
        LYItem *ithItem = [self.allItems objectAtIndex:i];
        
        if ([ithItem inShoppingList]) {
            [buffer addObject:ithItem];
        }
    }
    
    self.items = [NSArray arrayWithArray:buffer];
}

- (NSString *)pathForItems {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    
    return [documents stringByAppendingPathComponent:@"items.plist"];
}

- (void)updateShoppingList:(NSNotification *)notification {
    self.allItems = [LYItemHelper loadItems];
}

@end
