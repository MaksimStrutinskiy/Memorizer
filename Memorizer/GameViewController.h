//
//  GameViewController.h
//  Memorizer
//
//  Created by Maksim Strytinskiy on 6/26/13.
//  Copyright (c) 2013 Maksim Strytinskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

+ (void)amountOfWords:(int)amount;
+ (void)timeInterval:(int)interval;

+ (int)amountOfWords;
+ (int)timeInterval;

@end
