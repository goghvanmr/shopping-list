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

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) LYItem *selection;

@end

@implementation LYListViewController

@synthesize items = _items;
@synthesize selection = _selection;

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
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                 target:self
                                                 action:@selector(addItem:)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                 target:self
                                                 action:@selector(editItem:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"add_item_from_list"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        LYAddItemViewController *destination = [nc.viewControllers firstObject];
        destination.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"edit_item_from_list"]) {
        LYEditItemViewController *destination = (LYEditItemViewController *)segue.destinationViewController;
        destination.item = self.selection;
        
        destination.delegate = self;
    }
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.title = @"Items";
        self.items = [NSMutableArray arrayWithArray:[LYItemHelper loadItemsFromFile]];
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
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self saveItems];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    LYItem *item = [self.items objectAtIndex:[indexPath row]];
    
    if (item) {
        self.selection = item;
        [self performSegueWithIdentifier:@"edit_item_from_list" sender:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LYItem *item = [self.items objectAtIndex:[indexPath row]];
    item.inShoppingList = !item.inShoppingList;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (item.inShoppingList) {
        cell.imageView.image = [UIImage imageNamed:@"checkmark"];
    }
    else {
        cell.imageView.image = nil;
    }
    
    [self saveItems];
}

#pragma mark - LYAddItemViewControllerDelegate

- (void)controller:(LYAddItemViewController *)controller didSaveItemWithName:(NSString *)name andPrice:(float)price {
    LYItem *item = [LYItem createItemWithName:name andPrice:price];
    
    [self.items addObject:item];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.items count]-1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self saveItems];
}

#pragma mark - LYEditItemViewControllerDelegate

- (void)controller:(UIViewController *)controller didUpdateItem:(LYItem *)item {
    for (int i = 0; i < [self.items count]; i++) {
        LYItem *iThItem = [self.items objectAtIndex:i];
        if ([iThItem.uuid isEqualToString:item.uuid]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
    [self saveItems];
}

#pragma mark - Private Methods

- (void)saveItems {
    [LYItemHelper saveItems:self.items];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShoppingListDidChangeNotification" object:nil];
}

- (void)addItem:(id)sender {
    [self performSegueWithIdentifier:@"add_item_from_list" sender:self];
}

- (void)editItem:(id)sender {
    [self.tableView setEditing:![self.tableView isEditing] animated:YES];
}

@end
