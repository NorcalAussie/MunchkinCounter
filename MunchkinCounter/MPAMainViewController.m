//
//  MPAMainViewController.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import "MPAMainViewController.h"
#import "MPAPlayer.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    //self.navigationItem.leftBarButtonItem = nil;
        
    //Initialize ints
    self.currentPlayerIndex = 0;
    
    //Initialize labels to defaults
    self.levelLabel.text = @"1";
    self.gearLabel.text = @"0";
    self.strengthLabel.text = @"1";
    
    //Initialize Array
    self.players = [[NSMutableArray alloc] initWithCapacity:_numberOfPlayers];
    
    [self setUpPlayers];
    
    self.navBarTextField.frame = CGRectMake(0, 0, 100, 22);
    self.navBarTextField.text = @"Player1";
    self.navBarTextField.textColor = [UIColor blackColor];
    self.navBarTextField.font = [UIFont boldSystemFontOfSize:19];
    self.navBarTextField.textAlignment = NSTextAlignmentCenter;
    self.navBarTextField.backgroundColor = [UIColor clearColor];
    [self.navBarTextField setBorderStyle:UITextBorderStyleNone];
    
    self.navBarTitle.titleView = self.navBarTextField;
    
    self.warriorSwitch.on = NO;
    
    [self.navBarTextField setDelegate:self];

    
    //Logs
    NSLog(@"Number of Players:%d",_numberOfPlayers);
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

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

}

- (IBAction)newGame:(id)sender {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
