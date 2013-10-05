//
//  NSManagedObject+ACCoreDataHelpers.h
//  ProCoreData1
//
//  Created by Aleksey on 05.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ACCoreDataHelpers)

+ (id)AC_create;

+ (NSArray *)AC_findAll;

+ (NSArray *)AC_findAllSortedBy:(NSString *)sortKey
                      ascending:(BOOL)ascending;
@end
