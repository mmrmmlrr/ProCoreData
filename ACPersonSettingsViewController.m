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
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *teamPicker;
@property (nonatomic, strong) ACPerson *person;
@property (nonatomic) NSUInteger mode;

- (IBAction)addNewTeamButtonClick:(id)sender;
- (IBAction)doneButtonClick:(id)sender;
- (IBAction)textFieldDidEndOnExit:(id)sender;


@end

@implementation ACPersonSettingsViewController

- (id)initWithPerson:(ACPerson *)person {
    if (self = [super init]) {
        self.teams = [NSMutableArray arrayWithArray:[ACTeam AC_findAll]];
        if (person) {
            self.person = person;
            [self setMode:ACPersonSettingsModeEdit];
        } else {
            [self setMode:ACPersonSettingsModeCreate];
        }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.mode == ACPersonSettingsModeEdit) {
        [self.personNameTextField setText:self.person.name];
        [self.ageTextField setText:[NSString stringWithFormat:@"%i",[self.person.age integerValue]]];
        NSUInteger teamIndex = [self.teams indexOfObject:self.person.team];
        [self.teamPicker selectRow:teamIndex inComponent:0 animated:NO];
    }
}



- (IBAction)addNewTeamButtonClick:(id)sender {
    if ([self.teamNameTextField.text length] == 0) {
        [self showAlertView];
        return;
    }
    ACTeam *team = [ACTeam AC_create];
    [team setName:self.teamNameTextField.text];
    
    [self.teams addObject:team];
    
    [self.teamPicker reloadAllComponents];
}

- (IBAction)doneButtonClick:(id)sender {
    
    if ([self.personNameTextField.text length] == 0 || [self.ageTextField.text length] == 0) {
        [self showAlertView];
        return;
    }
    
    ACPerson *person = nil;
    
    switch (self.mode) {
        case ACPersonSettingsModeEdit:
            person = self.person;
            break;
        case ACPersonSettingsModeCreate:
            person = [ACPerson AC_create];
            break;
            
        default:
            break;
    }
    
    [person setName:self.personNameTextField.text];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    [person setAge:[formatter numberFromString:self.ageTextField.text]];
    [person setTeam:[self.teams objectAtIndex:[self.teamPicker selectedRowInComponent:0]]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [self.view endEditing:YES];
}

- (void)showAlertView {
    NSString *title = @"Error";
    NSString *message = @"Please fill all fields";
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
