//
//  ViewController.m
//  ToDoListobjC
//
//  Created by damir hodez on 04/03/2020.
//  Copyright © 2020 damir hodez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) NSMutableArray *categories;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = @[@{@"name" : @"do shopping", @"category" : @"Home"}].mutableCopy;
    [self.items addObject: @{@"name" : @"eat food", @"category" : @"Home"}];
    [self.items addObject: @{@"name" : @"buy lights", @"category" : @"Work"}];
    
    
    self.categories = @[@"Home", @"Work"].mutableCopy;
    
    self.navigationItem.title = @"To Do List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditing:)];
}

#pragma mark - Add New Item

- (void) addNewItem:(UIBarButtonItem *) sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add item" message:@"what item you want to add?" preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Item Name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Category Name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
    }];
    
    UIAlertAction *add = [UIAlertAction actionWithTitle:@"Add" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *itemName = alert.textFields[0].text;
        NSString *itemCategory = alert.textFields[1].text;
        
        if (![self.categories containsObject:itemCategory]) {
            [self.categories addObject:itemCategory];
        }
        
        NSDictionary *newItem = @{@"name" : itemName, @"category": itemCategory};
        
        [self.items addObject:newItem];

        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:nil];
    }];
    
    [alert addAction: add];
    [alert addAction: cancel];
    
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - Editing

- (void) toggleEditing: (UIBarButtonItem *) sender {
    [self.tableView setEditing: !self.tableView.isEditing animated:true];
    
    if (self.tableView.isEditing) {
        sender.title = @"Done";
        sender.style = UIBarButtonItemStyleDone;
    } else {
        sender.title = @"Edit";
        sender.style = UIBarButtonSystemItemEdit;
    }
    
}

#pragma mark - Data source helper methods

- (NSArray *) itemsInCategory: (NSString *)targetCategory {
    NSPredicate *targetPredicate = [NSPredicate predicateWithFormat:@"category == %@", targetCategory];
    NSArray *categoryItems = [self.items filteredArrayUsingPredicate: targetPredicate];
    return categoryItems;
}

- (NSDictionary *) itemAtIndexPath: (NSIndexPath *) indexPath {
    NSString *category = self.categories[indexPath.section];
    NSArray *categoryItems = [self itemsInCategory: category];
    NSDictionary *item = categoryItems[indexPath.row];
    return item;
}

- (NSInteger) indexForItem: (NSIndexPath *) indexPath {
    NSDictionary *item = [self itemAtIndexPath: indexPath];
    NSInteger index = [self.items indexOfObjectIdenticalTo: item];
    return index;
}

- (void) removeItemAtIndexPath: (NSIndexPath *) indexPath {
    NSInteger index = [self indexForItem:indexPath];
    [self.items removeObjectAtIndex: index];
}

- (void) removeCategory: (NSString *) category {
    [self.categories removeObject:category];
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *categoryItems = [self itemsInCategory:self.categories[section]];
    return categoryItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *item = [self itemAtIndexPath: indexPath];
    
    cell.textLabel.text = item[@"name"];
    
    cell.accessoryType = ([item[@"completed"] boolValue]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section];
}

#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self indexForItem:indexPath];

    NSMutableDictionary *item = [self.items[index] mutableCopy];
    
    BOOL completed = [item[@"completed"] boolValue];
    item[@"completed"] = @(!completed);
    self.items[index] = item;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = ([item[@"completed"] boolValue]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeItemAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationLeft];
        
        NSArray *categoryItems = [self itemsInCategory:self.categories[indexPath.section]];
        
        if (categoryItems.count == 0) {
            [self removeCategory:self.categories[indexPath.section]];
            [tableView deleteSections: [NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation: UITableViewRowAnimationLeft];
        }
    }
}


@end
