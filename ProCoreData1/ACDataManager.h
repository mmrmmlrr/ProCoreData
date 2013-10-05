//
//  YTDataManager.h
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACDataManager : NSObject

@property (nonatomic, getter = isLoggingAllowed) BOOL loggingAllowed;

+ (id)sharedManager;

- (id)createEntityForName:(NSString *)name;
- (NSArray *)allEntitiesForName:(NSString *)name;


@end
  