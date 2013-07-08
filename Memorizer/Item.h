//
//  Item.h
//  Memorizer
//
//  Created by Maksim Strytinskiy on 7/4/13.
//  Copyright (c) 2013 Maksim Strytinskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * word;

@end
