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

@end

@implementation MPAStartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Check for game in Progresss
    NSMutableArray *currentGame = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
    if(currentGame != nil){
        //If there is a current game skip this screen and go straight to game view
        [self performSegueWithIdentifier:@"startGameSegue" sender:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGame:(id)sender {

    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"startGameSegue"]){
        self.numberOfPlayers = [[self.textField text] intValue];
        self.tbc = (UITabBarController *) [segue destinationViewController];
        //self.mvc = (MPAMainViewController *) [self.tbc.viewControllers objectAtIndex:0];
        UINavigationController *navController = [self.tbc.viewControllers objectAtIndex:0];
        MPAMainViewController *mpa2 = (MPAMainViewController  *)navController.topViewController;
        mpa2.numberOfPlayers = self.numberOfPlayers;
        
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"startGameSegue"]) {
        if ([[self.textField text] intValue] >= 2 && [[self.textField text] intValue] <= 10){
            return YES;
        }
    }
    NSLog(@"did not enter valid number");
    return NO;
}


@end
