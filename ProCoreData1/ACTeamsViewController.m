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
#import <CoreData/CoreData.h>

@interface ACTeamsViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *teams;

@end

@implementation ACTeamsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.teams = [ACTeam findAll];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *createNewPersonButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(createNewPersonButtonClick:)];
    [self.navigationItem setRightBarButtonItem:createNewPersonButton];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.teams = [ACTeam findAll];
    [self.tableView reloadData];
}


- (void)createNewPersonButtonClick:(id)sender {
    ACPersonSettingsViewController *settingsController = [ACPersonSettingsViewController new];
    [self.navigationController pushViewController:settingsController animated:YES];
}


#pragma mark - TableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ACTeam *team = [self.teams objectAtIndex:section];
    return [team.persons count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.teams count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *sectionNames = [NSMutableArray array];
    for (ACTeam *team in self.teams) {
        [sectionNames addObject:team.name];
    }
    return sectionNames;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ACTeam *team = [self.teams objectAtIndex:indexPath.section];
    NSArray *persons = [team.persons allObjects];
    ACPerson *person = [persons objectAtIndex:indexPath.row];
    [cell.textLabel setText:person.name];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 320., 40.)];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.frame];
    [headerView addSubview:label];
    ACTeam *team = [self.teams objectAtIndex:section];
    [label setText:team.name];
    return headerView;
}

@end
