//
//  MPAStartScreenViewController.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import "MPAStartScreenViewController.h"
#import "MPAMainViewController.h"

@interface MPAStartScreenViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic) int numberOfPlayers;
@property (strong, nonatomic) UITabBarController *tbc;
@property (strong, nonatomic) MPAMainViewController *mvc;

@property (nonatomic) NSMutableArray *currentGame;

@end

@implementation MPAStartScreenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    


}

- (void)viewDidAppear:(BOOL)animated {
    //Check for game in Progresss
    self.currentGame = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
    if(self.currentGame != nil){
        //If there is a current game skip this screen and go straight to game view
        [self performSegueWithIdentifier:@"startGameSegue" sender:self];
    } else {
        self.view.hidden = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGame:(id)sender {

    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)tapDetected:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"startGameSegue"]){
        if (self.currentGame == nil) {
            self.numberOfPlayers = [[self.textField text] intValue];
            self.tbc = (UITabBarController *) [segue destinationViewController];
            UINavigationController *navController = [self.tbc.viewControllers objectAtIndex:0];
            MPAMainViewController *mpa2 = (MPAMainViewController  *)navController.topViewController;
            mpa2.numberOfPlayers = self.numberOfPlayers;
        }
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"startGameSegue"]) {
        if (([[self.textField text] intValue] >= 2 && [[self.textField text] intValue] <= 10) || self.currentGame != nil){
            return YES;
        }
    }
    NSLog(@"did not enter valid number");
    return NO;
}


@end
