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

- (NSString *)description {
    return [NSString stringWithFormat:@"\nname: %@ \n"
            "age: %i\n\n",self.name, [self.age integerValue]];
}

@end
