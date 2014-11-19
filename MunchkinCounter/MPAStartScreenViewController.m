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

@end

@implementation MPAStartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        MPAMainViewController *mvc = [segue destinationViewController];
        mvc.numberOfPlayers = self.numberOfPlayers;
        
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
