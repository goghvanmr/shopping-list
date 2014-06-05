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
    // Dispose of any resources that can be recreated.
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
    }
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

#pragma mark - LYAddItemViewControllerDelegate

- (void)controller:(LYAddItemViewController *)controller didSaveItemWithName:(NSString *)name andPrice:(float)price {
    LYItem *item = [LYItem createItemWithName:name andPrice:price];
    
    [self.items addObject:item];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.items count]-1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self saveItems];
}


#pragma mark - Private Methods

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
    [self performSegueWithIdentifier:@"add_item_from_list" sender:self];
}

- (void)editItem:(id)sender {
    [self.tableView setEditing:![self.tableView isEditing] animated:YES];
}

@end
