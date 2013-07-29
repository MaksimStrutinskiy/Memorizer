//
//  GameViewController.m
//  Memorizer
//
//  Created by Maksim Strytinskiy on 6/26/13.
//  Copyright (c) 2013 Maksim Strytinskiy. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"
#import "Item.h"

NSString *const CORRECT_ANSWER_IMAGE_PATH = @"correctAnswer.png";
NSString *const INCORRECT_ANSWER_IMAGE_PATH = @"incorrectAnswer.png";

static int AMOUNT_OF_WORDS = 7;
static int TIMER_INTERVAL = 5;

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *answerTipView;
@property (weak, nonatomic) IBOutlet UIImageView *answerTipImage;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) Game *game;
@property NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *timeLeftLabel;

@end

@implementation GameViewController
// LOCALS
int timeLeft;
int hiddenItem;
NSString *hiddenItemName;

// VIEW
- (NSMutableArray *)tableData {
    if(!_tableData) _tableData = [NSMutableArray new];
    return _tableData;
}

- (Game *)game {
    if(!_game) _game = [[Game alloc] init];
    return _game;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startGame];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self endTimer];
    [super viewWillDisappear:animated];
}

- (IBAction)answerButtonClick:(id)sender {
    if([self checkAnswer]) {
        self.answerTipImage.image = [UIImage imageNamed:CORRECT_ANSWER_IMAGE_PATH];
        self.answerTipView.hidden = NO;
        [self showAlert];
    }
    else {
        self.answerTipImage.image = [UIImage imageNamed:INCORRECT_ANSWER_IMAGE_PATH];
        self.answerTipView.hidden = NO;
    }
}

- (IBAction)restartButtonClick:(id)sender {
    [self endTimer];
    _game = nil;
    [self startGame];
    [self.tableView reloadData];
}

// GAME
- (void)startGame {
    self.answerTextField.text = @"";
    self.answerView.hidden = YES;
    self.answerTipView.hidden = YES;
    self.tableData = [[NSMutableArray alloc]init];
    for(int i=0; i<AMOUNT_OF_WORDS; i++) {
        [self.tableData addObject:[self.game getRandomWord]];
    }
    [self startTimer];
}

- (void)hideRandomItem {
    hiddenItem = arc4random() % self.tableData.count;
    hiddenItemName = [self.tableData objectAtIndex:hiddenItem];
    [self.tableData replaceObjectAtIndex:hiddenItem withObject:@""];
    [self.tableView reloadData];
    self.answerView.hidden = NO;
}

- (BOOL)checkAnswer {
    if([hiddenItemName isEqualToString:self.answerTextField.text]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CONGRAT_WINDOW_TITLE", nil)
                                                    message:NSLocalizedString(@"CONGRAT_WINDOW_TEXT", nil) delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"CONGRAT_WINDOW_BACK_TO_MENU_BUTTON", nil)
                                          otherButtonTitles:NSLocalizedString(@"CONGRAT_WINDOW_PLAY_AGAIN_BUTTON", nil), nil];
    [alert show];
}

// TIMER
- (void)startTimer {
    timeLeft = TIMER_INTERVAL;
    self.timeLeftLabel.title = [NSString stringWithFormat:@"%d",timeLeft];
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countingTimer) userInfo:nil repeats:YES];
}

- (void)endTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)countingTimer {
    if(timeLeft > 1) {
        timeLeft--;
        self.timeLeftLabel.title = [NSString stringWithFormat:@"%d",timeLeft];
    }
    else {
        [self endTimer];
        [self hideRandomItem];
    }
}

// DELEGATING
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleTableID = @"simpleTableID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableID];
    cell == nil ? cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableID]:nil;
    
    //NSManagedObject *item = [self.items objectAtIndex:indexPath.row];
    //[cell.textLabel setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"word"]]];

    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self restartButtonClick:nil];
    }
}

// STATIC
+ (void)amountOfWords:(int)amount {
    AMOUNT_OF_WORDS = amount;
}

+ (void)timeInterval:(int)interval {
    TIMER_INTERVAL = interval;
}

+ (int)amountOfWords {
    return AMOUNT_OF_WORDS;
}

+ (int)timeInterval {
    return TIMER_INTERVAL;
}

@end
