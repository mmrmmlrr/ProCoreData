//
//  ACTeam.h
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ACTeam : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *persons;

@end
