//
//  ACDefaultsManager.m
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACDefaultsManager.h"
#import "ACTeam+Create.h"
#import "ACPerson+Create.h"

@implementation ACDefaultsManager

+ (id)sharedManager {
    static id sharedManager;
    static dispatch_once_t onceSharingManagerCreate;
    dispatch_once(&onceSharingManagerCreate, ^{
        sharedManager = [[ACDefaultsManager alloc] init];
    });
    return sharedManager;
}

- (void)createDefaultTeamsIfNeeded {
    if ([[ACTeam findAll ] count] == 0) {
        ACTeam *team = [ACTeam create];
        [team setName:@"Lucky"];
        
        ACPerson *person = [ACPerson create];
        [person setName:@"Aleksey"];
        [person setBirthDate:[NSDate date]];
        [person setTeam:team];
    }
}

@end
