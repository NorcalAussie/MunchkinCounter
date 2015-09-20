//
//  MPAMainViewController.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import "MPAMainViewController.h"
#import "MPAPlayer.h"
#import "MPABattleViewController.h"

@interface MPAMainViewController ()
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *gearLabel;
@property (strong, nonatomic) IBOutlet UILabel *strengthLabel;
@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (strong, nonatomic) IBOutlet UITextField *navBarTextField;
@property (strong, nonatomic) IBOutlet UISwitch *warriorSwitch;

@property (strong, nonatomic) MPAPlayer *currentPlayer;

@property (nonatomic) int currentPlayerIndex;

@end

@implementation MPAMainViewController

@synthesize numberOfPlayers;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.tabBarController.delegate = self;
    
    self.navBarTextField.frame = CGRectMake(0, 0, 100, 22);
    self.navBarTextField.textColor = [UIColor blackColor];
    self.navBarTextField.textAlignment = NSTextAlignmentCenter;
    self.navBarTextField.backgroundColor = [UIColor clearColor];
    self.navBarTextField.allowsEditingTextAttributes = true;
    [self.navBarTextField setBorderStyle:UITextBorderStyleNone];
    
    self.navBarTitle.titleView = self.navBarTextField;
    self.navBarTextField.delegate = self;

    [self.navBarTextField setFont:[UIFont fontWithName:@"Noteworthy" size:14.0]];
    
    //Set Up NSUserDefualts
    NSMutableArray *currentGame = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
    if(currentGame == nil){
        //If nil, no saved game so initialize out array normally
        self.players = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
        
        //Initialize ints
        self.currentPlayerIndex = 0;
        
        //Initialize labels to defaults
        self.levelLabel.text = @"1";
        self.gearLabel.text = @"0";
        self.strengthLabel.text = @"1";
        self.navBarTextField.text = @"Player1";
        self.warriorSwitch.on = NO;
        
        [self setUpPlayers];
    } else {
        //Else initialize our array with the NSUserDefualt Data
        NSData *gameData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
        self.players = [NSKeyedUnarchiver unarchiveObjectWithData:gameData];
        
        self.numberOfPlayers = (int)[self.players count];
        
        [self setCurrentPlayer];
        [self update];
    }
}

#pragma mark - Helper Functions
- (void)setUpPlayers {
    int playerNumber = 1;
    
    for(int i=0; i<self.numberOfPlayers; i++){
        NSString *playerName = [NSString stringWithFormat:@"Player%d",playerNumber];
        
        //Initilize Player
        MPAPlayer *player = [[MPAPlayer alloc] initWithName:playerName];
        
        //Add Player to players array
        [self.players addObject:player];
        
        playerNumber++;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.players];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentGame"];
    self.currentPlayer = self.players[0];
}

- (void)update {
    [self setCurrentPlayer];
    
    self.currentPlayer.strength = self.currentPlayer.level + self.currentPlayer.gear;
    
    self.navBarTextField.text = self.currentPlayer.name;
    self.levelLabel.text = [NSString stringWithFormat:@"%d",self.currentPlayer.level];
    self.gearLabel.text = [NSString stringWithFormat:@"%d",self.currentPlayer.gear];
    self.strengthLabel.text = [NSString stringWithFormat:@"%d",self.currentPlayer.strength];
    
    if(self.currentPlayer.isWarrior) {
        self.warriorSwitch.on = YES;
        
    }else if(!self.currentPlayer.isWarrior) {
        self.warriorSwitch.on = NO;
        
    }
    
    [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:self.currentPlayer];
    
    //Update UserDefaults
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.players];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentGame"];
}

- (void)setCurrentPlayer {
    self.currentPlayer = [self.players objectAtIndex:self.currentPlayerIndex];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.navBarTextField resignFirstResponder];
    return YES;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[MPABattleViewController class]]) {
        MPABattleViewController *svc = (MPABattleViewController *) viewController;
        svc.currentPlayerStrength = self.currentPlayer.strength;
        svc.currentPlayerWarrior = self.currentPlayer.isWarrior;
    }
    return TRUE;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(UIEventSubtypeMotionShake) {
        int rollNumber = arc4random()%6;
        NSString *rollMessage = [NSString stringWithFormat:@"You rolled a %d", rollNumber];
        
        UIAlertController *dieRoll = [UIAlertController alertControllerWithTitle:@"Die Roll" message:rollMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [dieRoll addAction:ok];
        
        [self presentViewController:dieRoll animated:YES completion:nil];
    }
}

#pragma mark - IBactions
- (IBAction)nameChange:(id)sender {
    UITextView *tv = (UITextView *)sender;
    self.currentPlayer.name = tv.text;
    [self update];
}

- (IBAction)previousPlayer:(id)sender {
    if(self.currentPlayerIndex == 0) {
        self.currentPlayerIndex = self.numberOfPlayers - 1;
        
    } else {
        self.currentPlayerIndex--;
    }
    [self update];
}

- (IBAction)nextPlayer:(id)sender {
    if(self.currentPlayerIndex == self.numberOfPlayers - 1) {
        self.currentPlayerIndex = 0;

    } else {
        self.currentPlayerIndex++;
    }
    [self update];
}

- (IBAction)addLevel:(id)sender {
    self.currentPlayer.level++;
    [self update];
    
}

- (IBAction)subtractLevel:(id)sender {
    if(self.currentPlayer.level > 0) {
        self.currentPlayer.level--;
        [self update];
    }
}

- (IBAction)addGear:(id)sender {
    self.currentPlayer.gear++;
    [self update];
}

- (IBAction)subtractGear:(id)sender {
    self.currentPlayer.gear--;
    [self update];
}

- (IBAction)setWarrior:(id)sender {
    if (self.currentPlayer.isWarrior) {
        self.currentPlayer.isWarrior = false;
        
    }else if (!self.currentPlayer.isWarrior) {
        self.currentPlayer.isWarrior = true;
    }
    [self update];
}

- (IBAction)newGame:(id)sender {
    //Confirm with user
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //Clear NSUserDefualt Data
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentGame"];
        [self performSegueWithIdentifier:@"newGameSegue" sender:self];
        
    }];
    
    [ac addAction:cancel];
    [ac addAction:confirm];
    
    [self presentViewController:ac animated:YES completion:nil];
}

@end
