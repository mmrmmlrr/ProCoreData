//
//  ACDefaultsManager.h
//  ProCoreData1
//
//  Created by Aleksey on 04.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACDefaultsManager : NSObject

+ (ACDefaultsManager *)sharedManager;

- (void)createDefaultTeamsIfNeeded;

@end
