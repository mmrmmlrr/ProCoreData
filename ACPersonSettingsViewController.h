//
//  ACPersonSettingsViewController.h
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACPerson;

typedef enum {
    ACPersonSettingsModeCreate,
    ACPersonSettingsModeEdit
}ACPersonSettingsMode;

@interface ACPersonSettingsViewController : UIViewController

- (id)initWithPerson:(ACPerson *)person;
@end

