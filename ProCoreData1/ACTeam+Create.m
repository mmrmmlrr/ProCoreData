//
//  ACTeam+Create.m
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACTeam+Create.h"
#import "ACDataManager.h"

static NSString *const entityName = @"ACTeam";

@implementation ACTeam (Create)

+ (ACTeam *)create {
    return [[ACDataManager sharedManager]createEntityForName:entityName];
}

+ (NSArray *)findAll {
    return [[ACDataManager sharedManager]allEntitiesForName:entityName];
}

- (NSString *)description {
    return  [NSString stringWithFormat:@"ACTeam name:%@", self.name];
}

@end
