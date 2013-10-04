//
//  YTViewController.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACTeamsViewController.h"
#import "ACPersonSettingsViewController.h"
#import <CoreData/CoreData.h>

@interface ACTeamsViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ACTeamsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *createNewPersonButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(createNewPersonButtonClick:)];
    [self.navigationItem setRightBarButtonItem:createNewPersonButton];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)createNewPersonButtonClick:(id)sender {
    ACPersonSettingsViewController *settingsController = [ACPersonSettingsViewController new];
    [self.navigationController pushViewController:settingsController animated:YES];
}


#pragma mark - TableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

@end
