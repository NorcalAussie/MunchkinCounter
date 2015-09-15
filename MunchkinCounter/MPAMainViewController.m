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

@property (nonatomic) int currentPlayerIndex;

@end

@implementation MPAMainViewController

@synthesize numberOfPlayers;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    //self.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.delegate = self;
    
    self.navBarTextField.frame = CGRectMake(0, 0, 100, 22);
    self.navBarTextField.textColor = [UIColor blackColor];
    self.navBarTextField.font = [UIFont boldSystemFontOfSize:19];
    self.navBarTextField.textAlignment = NSTextAlignmentCenter;
    self.navBarTextField.backgroundColor = [UIColor clearColor];
    [self.navBarTextField setBorderStyle:UITextBorderStyleNone];
    
    self.navBarTitle.titleView = self.navBarTextField;
    self.navBarTextField.delegate = self;
    
    //[self.navBarTextField setDelegate:self];
    //cell.textLabel?.font = UIFont(name: "Avenir-LightOblique", size: 12.0)
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
        
    }else{
        //Else initialize our array with the NSUserDefualt Data
        NSData *gameData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
        self.players = [NSKeyedUnarchiver unarchiveObjectWithData:gameData];
        
        self.numberOfPlayers = (int)[self.players count];
        
        [self update];
        
    }

    
    //Logs
    NSLog(@"Number of Players:%d",numberOfPlayers);
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - Helper Functions

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[MPABattleViewController class]]){
        MPABattleViewController *svc = (MPABattleViewController *) viewController;
        MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
        svc.currentPlayerStrength = player.strength;
        svc.currentPlayerWarrior = player.isWarrior;
    }
    return TRUE;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(UIEventSubtypeMotionShake){
        int rollNumber = arc4random()%6;
        NSString *rollMessage = [NSString stringWithFormat:@"You rolled a %d", rollNumber];
        UIAlertView *dieRoll = [[UIAlertView alloc] initWithTitle:@"Die Roll" message:rollMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [dieRoll show];
    }
    
}

- (void)update {
    
    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    
    player.strength = player.level + player.gear;
    
    self.navBarTextField.text = player.name;
    self.levelLabel.text = [NSString stringWithFormat:@"%d",player.level];
    self.gearLabel.text = [NSString stringWithFormat:@"%d",player.gear];
    self.strengthLabel.text = [NSString stringWithFormat:@"%d",player.strength];
    
    if(player.isWarrior){
        self.warriorSwitch.on = YES;
        
    }else if(!player.isWarrior){
        self.warriorSwitch.on = NO;
        
    }
    
    [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:player];
    
    //Update UserDefaults
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.players];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentGame"];
    
}

- (void)setUpPlayers{
    
    int playerNumber = 1;
    
    for(int i=0; i<self.numberOfPlayers; i++){
        NSString *playerName = [NSString stringWithFormat:@"Player%d",playerNumber];
        NSLog(@"Initializing Player%d", playerNumber);
        
        //Initilize Player
        MPAPlayer *player = [[MPAPlayer alloc] initWithName:playerName];
        
        //Add Player to players array
        [self.players addObject:player];
        
        playerNumber++;
        
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.players];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentGame"];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.navBarTextField resignFirstResponder];
    return YES;
    
}

#pragma mark - IBactions

- (IBAction)nameChange:(id)sender{
    
    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    UITextView *tv = (UITextView *)sender;
    player.name = tv.text;
    [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:player];
    [self update];
    
}

- (IBAction)previousPlayer:(id)sender {
    
    if(self.currentPlayerIndex == 0){
        self.currentPlayerIndex = self.numberOfPlayers - 1;
        
    }else{
        self.currentPlayerIndex--;
    }
    
    [self update];
    
}

- (IBAction)nextPlayer:(id)sender {
    
    if(self.currentPlayerIndex == self.numberOfPlayers - 1){
        self.currentPlayerIndex = 0;

    }else{
        self.currentPlayerIndex++;
    }
    
    [self update];
    
}

- (IBAction)addLevel:(id)sender {
    
    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    player.level++;
    [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:player];
    
    [self update];
    
}

- (IBAction)subtractLevel:(id)sender {
    
    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    if(player.level > 0){
        player.level--;
        [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:player];
        [self update];
    }

}

- (IBAction)addGear:(id)sender {

    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    player.gear++;
    [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:player];
    [self update];

}

- (IBAction)subtractGear:(id)sender {

    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    player.gear--;
    [self.players replaceObjectAtIndex:self.currentPlayerIndex withObject:player];
    [self update];

}

- (IBAction)setWarrior:(id)sender {
    
    MPAPlayer *player = [self.players objectAtIndex:self.currentPlayerIndex];
    if (player.isWarrior){
        player.isWarrior = false;
        
    }else if (!player.isWarrior){
        player.isWarrior = true;
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
