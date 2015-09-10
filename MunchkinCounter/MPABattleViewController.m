//
//  MPABattleViewController.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 9/9/15.
//  Copyright (c) 2015 MPApps. All rights reserved.
//

#import "MPABattleViewController.h"

@interface MPABattleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *monsterLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *modifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *differenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic) int monsterLevel;
@property (nonatomic) int modifier;
@property (nonatomic) int difference;
@property (nonatomic) int numberToAdd;

@end

@implementation MPABattleViewController

@synthesize currentPlayerLevel;
@synthesize currentPlayerWarrior;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.monsterLevel = 0;
    self.modifier = 0;
    self.difference = 0;
    self.numberToAdd = 1;
    
    self.segmentedControl.selectedSegmentIndex = 0;
    // Do any additional setup after loading the view.
}

- (void)update {
    self.monsterLevelLabel.text = [NSString stringWithFormat:@"%d", self.monsterLevel];
    self.modifierLabel.text = [NSString stringWithFormat:@"%d", self.modifier];
    self.difference = self.currentPlayerLevel - (self.monsterLevel + self.modifier);
    self.differenceLabel.text = [NSString stringWithFormat:@"%d", self.difference];
    
    if (self.difference > 0) {
        self.resultLabel.text = @"You Win";
    } else if (self.difference < 0) {
        self.resultLabel.text = @"You Lose";
    } else if (self.difference == 0) {
        if (self.currentPlayerWarrior) {
            self.resultLabel.text = @"You Win";
        } else if (!self.currentPlayerWarrior) {
            self.resultLabel.text = @"You Lose";
        }
    }

}

- (IBAction)segmentChanged:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0){
        self.numberToAdd = 1;
    } else if (self.segmentedControl.selectedSegmentIndex == 1){
        self.numberToAdd = 5;
    } else if (self.segmentedControl.selectedSegmentIndex == 2){
        self.numberToAdd = 10;
    }
}

- (IBAction)increaseMonsterLevel:(id)sender {
    self.monsterLevel += self.numberToAdd;
    [self update];
}

- (IBAction)decreaseMonsterLevel:(id)sender {
    if ((self.monsterLevel - self.numberToAdd) > 0){
        self.monsterLevel -= self.numberToAdd;
        [self update];
    }
}

- (IBAction)increaseModifier:(id)sender {
    self.modifier+= self.numberToAdd;
    [self update];
}

- (IBAction)decreaseModifer:(id)sender {
    self.modifier-= self.numberToAdd;
    [self update];
}


@end
