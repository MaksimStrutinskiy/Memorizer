//
//  Game.m
//  TestProject
//
//  Created by Maksim Strytinskiy on 6/18/13.
//  Copyright (c) 2013 Maksim Strytinskiy. All rights reserved.
//

#import "Game.h"
#import "CoreDataHelper.h"
#import "Item.h"

@interface Game ()

@property (strong, nonatomic) NSMutableArray *items;
@property (nonatomic, strong) CoreDataHelper *CDH;

@end

@implementation Game

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (CoreDataHelper *)CDH {
    if (!_CDH) _CDH = [CoreDataHelper getInstance];
    return _CDH;
}

- (id)init {
    /*
    if ((self = [super init])) {
        [self.items addObject:@"ant"];
        [self.items addObject:@"bird"];
        [self.items addObject:@"bee"];
        [self.items addObject:@"bear"];
        [self.items addObject:@"cat"];
        [self.items addObject:@"camel"];
        [self.items addObject:@"crab"];
        [self.items addObject:@"chicken"];
        [self.items addObject:@"cow"];
        [self.items addObject:@"dog"];
        [self.items addObject:@"elephant"];
        [self.items addObject:@"fish"];
        [self.items addObject:@"fox"];
        [self.items addObject:@"fly"];
        [self.items addObject:@"goat"];
        [self.items addObject:@"horse"];
        [self.items addObject:@"hyena"];
        [self.items addObject:@"kangaroo"];
        [self.items addObject:@"lion"];
        [self.items addObject:@"monkey"];
        [self.items addObject:@"panda"];
        [self.items addObject:@"penguin"];
        [self.items addObject:@"pig"];
        [self.items addObject:@"rabbit"];
        [self.items addObject:@"salmon"];
        [self.items addObject:@"shark"];
        [self.items addObject:@"sheep"];
        [self.items addObject:@"snake"];
        [self.items addObject:@"tiger"];
        [self.items addObject:@"whale"];
        [self.items addObject:@"wolf"];
        [self.items addObject:@"worm"];
        [self.items addObject:@"zebra"];
    }*/
    
    NSMutableArray *entities;
    entities = [self.CDH selectAllItems];
    
    //[self.CDH deleteAll:self.items];
    //entities = [self newDataCore];
    
    for (int i=0; i <entities.count; i++) {
        Item *item = [entities objectAtIndex:i];
        [self.items addObject:item.word];
    }
    return self;
}

- (id)initWithArray:(NSArray *)array {
    if ((self = [super init])) {
        _items = [[NSMutableArray alloc] init];
        for(NSString *item in array) {
            [self.items addObject:item];
        }
    }
    return self;
}

- (NSString *)getRandomWord {
      NSString *randomItem = nil;
      if ([self maxItems] > 0) {
          unsigned index = arc4random() % self.items.count;
          randomItem = self.items[index];
          [self.items removeObjectAtIndex:index];
      }
      return randomItem;
}

- (int)maxItems {
    return self.items.count;
}

- (NSMutableArray *)newDataCore {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    while ([self maxItems] > 0) {
        [items addObject:[self.CDH insertItem]];
        [items.lastObject setValue:[self getRandomWord] forKey:@"word"];
    }
    
    [self.CDH saveContext];
    return items;
}
@end
