//
//  MPAMainViewController.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import "MPAMainViewController.h"

@interface MPAMainViewController ()
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *gearLabel;
@property (strong, nonatomic) IBOutlet UILabel *strengthLabel;
@property (strong, nonatomic) NSMutableArray *players;

@property (nonatomic) int level;
@property (nonatomic) int gear;
@property (nonatomic) int strength;
@property (nonatomic) int currentPlayerIndex;

@end

@implementation MPAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    //Initialize ints
    self.level = 1;
    self.gear = self.strength = self.currentPlayerIndex = 0;
    
    //Initialize labels to defaults
    self.levelLabel.text = [NSString stringWithFormat:@"%d",self.level];
    self.gearLabel.text = [NSString stringWithFormat:@"%d",self.gear];
    self.strengthLabel.text = [NSString stringWithFormat:@"%d",self.strength];
    
    //Initialize Array
    self.players = [[NSMutableArray alloc] initWithCapacity:_numberOfPlayers];
    
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
    
    //Calculate new strength
    self.strength = self.level + self.gear;
    
    //Update labels
    self.levelLabel.text = [NSString stringWithFormat:@"%d",self.level];
    self.gearLabel.text = [NSString stringWithFormat:@"%d",self.gear];
    self.strengthLabel.text = [NSString stringWithFormat:@"%d",self.strength];
    
}

#pragma mark - IBactions

- (IBAction)addLevel:(id)sender {
    
    self.level++;
    [self update];
    
}

- (IBAction)subtractLevel:(id)sender {
    
    if(self.level > 0){
        self.level--;
        [self update];
    }

}

- (IBAction)addGear:(id)sender {

    self.gear++;
    [self update];

}

- (IBAction)subtractGear:(id)sender {

    self.gear--;
    [self update];

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
