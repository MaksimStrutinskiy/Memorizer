//
//  SettingsViewController.m
//  Memorizer
//
//  Created by Maksim Strytinskiy on 6/27/13.
//  Copyright (c) 2013 Maksim Strytinskiy. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *amountOfWords;
@property (weak, nonatomic) IBOutlet UISlider *timeInterval;

@end

@implementation SettingsViewController

- (IBAction)amountOfWordsValueChanged:(id)sender {
    [GameViewController amountOfWords:(int)self.amountOfWords.value];
}

- (IBAction)timeIntervalValueChanged:(id)sender {
    [GameViewController timeInterval:(int)self.timeInterval.value];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.amountOfWords.value = [GameViewController amountOfWords];
    self.timeInterval.value = [GameViewController timeInterval];
}
@end
