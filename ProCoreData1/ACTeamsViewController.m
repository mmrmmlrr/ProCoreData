//
//  YTViewController.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACTeamsViewController.h"
#import <CoreData/CoreData.h>

@interface ACTeamsViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


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
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
