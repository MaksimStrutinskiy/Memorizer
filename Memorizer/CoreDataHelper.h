//
//  CoreDataHelper.h
//  MyStore
//
//  Created by Maksim Strytinskiy on 7/3/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

+ (CoreDataHelper *)getInstance;
- (NSManagedObject *)insertItem;
- (NSMutableArray *)selectAllItems;
- (void)deleteItem:(NSManagedObject *)item;
- (void)deleteAll:(NSMutableArray *)items;

@end
