//
//  YTViewController.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACTeamsViewController.h"
#import "ACPersonSettingsViewController.h"
#import "ACTeam+Create.h"
#import "ACPerson+Create.h"
#import "ACDataManager.h"
#import "ACDefaultsManager.h"

static NSString *const sortDescriptorKeyAge = @"age";
static NSString *const sortDescriptorKeyName = @"name";

@interface ACTeamsViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
NSFetchedResultsControllerDelegate
>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSString *currentSortDescriptorKey;

@end

@implementation ACTeamsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setCurrentSortDescriptorKey:sortDescriptorKeyName];
        [self initializeFetchedResultsController:self.currentSortDescriptorKey];
           }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *createNewPersonButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(createNewPersonButtonClick:)];
    
        UIBarButtonItem *reordeButton = [[UIBarButtonItem alloc] initWithTitle:@"sort" style:UIBarButtonItemStyleBordered target:self action:@selector(reorderButtonClick:)];
    
    [self.navigationItem setLeftBarButtonItem:reordeButton];
    [self.navigationItem setRightBarButtonItem:createNewPersonButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ACDefaultsManager sharedManager] createDefaultTeamsIfNeeded];
}

- (void)initializeFetchedResultsController:(NSString *)sortDescriptor {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([ACPerson class])];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:sortDescriptor ascending:YES];
    [request setSortDescriptors:@[descriptor]];
    NSManagedObjectContext *context = [[ACDataManager sharedManager] managedObjectContext];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:@"team.name"
                                                                                   cacheName:nil];
    [self.fetchedResultsController setDelegate:self];
    [self.fetchedResultsController performFetch:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)createNewPersonButtonClick:(id)sender {
    ACPersonSettingsViewController *settingsController = [[ACPersonSettingsViewController alloc]initWithPerson:nil];
    [self.navigationController pushViewController:settingsController animated:YES];
}

- (void)reorderButtonClick:(id)sender {
    
    self.currentSortDescriptorKey == sortDescriptorKeyAge ? [self setCurrentSortDescriptorKey:sortDescriptorKeyName] : [self setCurrentSortDescriptorKey:sortDescriptorKeyAge];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:self.currentSortDescriptorKey ascending:YES];
    [self.fetchedResultsController.fetchRequest setSortDescriptors:@[descriptor]];
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
    
}

#pragma mark - TableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:indexPath.section];
    ACPerson *person = [[sectionInfo objects]objectAtIndex:indexPath.row];
    
    NSString *output = [NSString stringWithFormat:@"%@, %@", person.name, person.age];

    [cell.textLabel setText:output];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica Bold" size:10]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 22.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 320., 40.)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10., 0., 320., 40.)];
    [headerView addSubview:label];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    [label setText:[sectionInfo name]];
    [label setFont:[UIFont fontWithName:@"Helvetica Bold" size:20]];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:indexPath.section];
    ACPerson *person = [[sectionInfo objects]objectAtIndex:indexPath.row];
    ACPersonSettingsViewController *settingsController = [[ACPersonSettingsViewController alloc]initWithPerson:person];
    [self.navigationController pushViewController:settingsController animated:YES];
}

#pragma mark - NSFetchedResultsController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView moveSection:sectionIndex
                              toSection:sectionIndex];
            
        default:
            break;
    }

}

-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }

}



@end
