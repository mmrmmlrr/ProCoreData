//
//  ACPersonSettingsViewController.m
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACPersonSettingsViewController.h"
#import "ACPerson+Create.h"
#import "ACTeam+Create.h"

@interface ACPersonSettingsViewController ()
<UIPickerViewDataSource,
UIPickerViewDelegate
>

@property (nonatomic, strong) NSMutableArray *teams;

@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *teamNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *teamPicker;

- (IBAction)addNewTeamButtonClick:(id)sender;
- (IBAction)doneButtonClick:(id)sender;
- (IBAction)textFieldDidEndOnExit:(id)sender;


@end

@implementation ACPersonSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.teams = [NSMutableArray arrayWithArray:[ACTeam findAll]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)addNewTeamButtonClick:(id)sender {
    if ([self.teamNameTextField.text length] == 0) {
        [self showAlertView];
        return;
    }
    ACTeam *team = [ACTeam create];
    [team setName:self.teamNameTextField.text];
    
    [self.teams addObject:team];
    
    [self.teamPicker reloadAllComponents];
}

- (IBAction)doneButtonClick:(id)sender {
    if ([self.personNameTextField.text length] == 0) {
        [self showAlertView];
        return;
    }
    
    ACPerson *person = [ACPerson create];
    [person setName:self.personNameTextField.text];
    [person setTeam:[self.teams objectAtIndex:[self.teamPicker selectedRowInComponent:0]]];
    
}

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [self.view endEditing:YES];
}

- (void)showAlertView {
    NSString *title = @"Error";
    NSString *message = @"Textfield can't be blank";
    NSString *cancelText = @"o.k.";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelText
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UIPickerView delegate and datasource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    ACTeam *team = [self.teams objectAtIndex:row];
    return team.name;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.teams count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
