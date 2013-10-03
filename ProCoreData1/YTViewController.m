//
//  YTViewController.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "YTViewController.h"
#import "YTBasicCanvas.h"

@interface YTViewController ()

@property (nonatomic, weak) IBOutlet YTBasicCanvas *topView;
@property (nonatomic, weak) IBOutlet YTBasicCanvas *bottomView;

@end

@implementation YTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
