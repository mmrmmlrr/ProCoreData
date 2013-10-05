//
//  ACPerson.h
//  ProCoreData1
//
//  Created by Aleksey on 05.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ACTeam;

@interface ACPerson : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) ACTeam *team;

@end
