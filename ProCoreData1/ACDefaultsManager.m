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

static NSString *const keyForNames = @"names";
static NSString *const keyForSecondNames = @"secondNames";
static NSString *const plistName = @"ACNamesList";


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
    if ([[ACTeam AC_findAll ] count] == 0) {
        ACTeam *team = [ACTeam AC_create];
        [team setName:@"Динамо"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSArray *names = [dictionary valueForKey:keyForNames];
        NSArray *secondNames = [dictionary valueForKey:keyForSecondNames];
        
        NSUInteger teamMembers = 5;
        
        for (NSUInteger idx = 0; idx < teamMembers; idx ++) {
            ACPerson *person = [ACPerson AC_create];
            [person setTeam:team];
            
            NSString *name = nil;
            NSString *secondName = nil;
            
            NSMutableString *fullName = [NSMutableString string];
            
            NSUInteger nameIndex = arc4random() % [names count];
            name = [names objectAtIndex:nameIndex];
            
            NSUInteger secondNameIndex = arc4random() % [secondNames count];
            secondName = [secondNames objectAtIndex:secondNameIndex];
            
            [fullName appendString:name];
            [fullName appendString:@" "];

            [fullName appendString:secondName];
            
            [person setName:fullName];
            
            [person setAge:@(arc4random() % 30 + 18)];
            
        }
    }
}

@end
