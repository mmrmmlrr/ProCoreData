//
//  YTDataManager.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACDataManager.h"
#import <CoreData/CoreData.h>

static NSString *const modelName = @"ProCoreDataModel";
ACDataManager *refToSelf;

@interface ACDataManager ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

@implementation ACDataManager

- (id)init {
    if (self = [super init]) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(applicationDidEnterBackground)
                                   name:@"UIApplicationDidEnterBackgroundNotification"
                                 object:nil];
        refToSelf = self;
    }
    return self;
}


+ (id)sharedManager {
    static id sharedManager;
    static dispatch_once_t onceSharingManagerCreate;
    dispatch_once(&onceSharingManagerCreate, ^{
        sharedManager = [[ACDataManager alloc] init];
    });
    return sharedManager;
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        } else {
                ACLog(@"Saving context on main thread");
        }
    }
}

#pragma mark - CoreData stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator) {
        _managedObjectContext = [NSManagedObjectContext new];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    ACLog(@"CoreData stack initialized successfully");
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName
                                              withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProCoreData.sqlite"];
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

#pragma mark - Application's documents directory

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

-(id) createEntityForName:(NSString *)name {
    NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:name
                                                                inManagedObjectContext:self.managedObjectContext];
    ACLog([NSString stringWithFormat:@"Created entity: %@", name]);
    return newEntity;
}

- (NSArray *)allEntitiesForName:(NSString *)name {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:name];
    [request setSortDescriptors:nil];
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}

#pragma mark -  Application Events observing

- (void)applicationDidEnterBackground {
    [self saveContext];

}

#pragma mark - Service methods and functions

void ACLog(NSString *logMessage){
    if ([refToSelf isLoggingAllowed]) {
        NSLog(@"%@", logMessage);
    }
}
@end


