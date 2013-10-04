//
//  ACPerson+Create.m
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACPerson+Create.h"
#import "ACDataManager.h"

static NSString *const entityName = @"ACPerson";

@implementation ACPerson (Create)

+ (ACPerson *)create {
    return [[ACDataManager sharedManager]createEntityForName:entityName];
}
+ (NSArray *)findAll {
    return [[ACDataManager sharedManager]allEntitiesForName:entityName];
}

@end
