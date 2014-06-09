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

@synthesize shoppingList = _shoppingList;
@synthesize items = _items;

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
        self.title = @"购物清单";
        
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
    
    self.items = [LYItemHelper items];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                 target:self
                                                 action:@selector(addItems:)];
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
    return [self.shoppingList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LYItem *item = [self.shoppingList objectAtIndex:[indexPath row]];
    cell.textLabel.text = item.name;
    
    return cell;
}

#pragma mark - Setters and Getters

- (void)setItems:(NSArray *)items {
    if (!_items) {
        _items = items;
    }
    
    [self buildShoppingList];
}

- (void)setShoppingList:(NSArray *)items {
    if (_shoppingList != items) {
        _shoppingList = items;
        
        [self.tableView reloadData];
    }
}

#pragma mark - Private Methods

- (void)buildShoppingList {
    NSMutableArray *buffer = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [self.items count]; i++) {
        LYItem *ithItem = [self.items objectAtIndex:i];
        
        if ([ithItem inShoppingList]) {
            [buffer addObject:ithItem];
        }
    }
    
    self.shoppingList = [NSArray arrayWithArray:buffer];
}

- (void)updateShoppingList:(NSNotification *)notification {
    self.items = [LYItemHelper items];
}

- (void)addItems:(id)send {
    [self performSegueWithIdentifier:@"from_shopping_list_to_item_list" sender:self];
}

@end
