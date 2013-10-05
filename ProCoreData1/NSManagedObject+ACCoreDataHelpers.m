//
//  NSManagedObject+ACCoreDataHelpers.m
//  ProCoreData1
//
//  Created by Aleksey on 05.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "NSManagedObject+ACCoreDataHelpers.h"
#import "ACDataManager.h"

@implementation NSManagedObject (ACCoreDataHelpers)

+ (id)AC_create {
    return [[ACDataManager sharedManager]createEntityForName:NSStringFromClass(self)];
}

+ (NSArray *)AC_findAll {
    return [[ACDataManager sharedManager]allEntitiesForName:NSStringFromClass(self)];
}

@end
