//
//  ACTeam.h
//  ProCoreData1
//
//  Created by Aleksey on 05.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ACPerson;

@interface ACTeam : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *persons;
@end

@interface ACTeam (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(ACPerson *)value;
- (void)removePersonsObject:(ACPerson *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;

@end
