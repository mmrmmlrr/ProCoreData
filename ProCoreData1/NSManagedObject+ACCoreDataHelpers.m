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

+ (NSArray *)AC_findAllSortedBy:(NSString *)sortKey
                      ascending:(BOOL)ascending {
    
    return [[self AC_findAll] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSComparisonResult result = NSOrderedSame;
        
        if (ascending) {
            result = [[obj1 valueForKey:sortKey] compare:[obj2 valueForKey:sortKey]];
        } else {
            result = [[obj2 valueForKey:sortKey] compare:[obj1 valueForKey:sortKey]];
        }
        return result;
    }];
}

+ (NSArray *)AC_findByAttribute:(NSString *)attribute
                               value:(id)value {
    NSMutableArray *entities = [NSMutableArray array];
    
    for (NSManagedObject *object in [self AC_findAll]) {
        if ([[object valueForKey:attribute] isEqual:value]) {
            [entities addObject:object];
        }
    }
    return entities;
}

- (void)AC_delete {
    [[ACDataManager sharedManager] deleteEntity:self];
}

@end
