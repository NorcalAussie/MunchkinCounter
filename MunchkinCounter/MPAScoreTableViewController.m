//
//  MPAScoreTableViewController.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 9/15/15.
//  Copyright (c) 2015 MPApps. All rights reserved.
//

#import "MPAScoreTableViewController.h"
#import "MPAScoreTableViewCell.h"
#import "MPAPlayer.h"

@interface MPAScoreTableViewController ()

@property (strong, nonatomic) NSMutableArray *players;

@end

@implementation MPAScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(15, 0, 0, 0)];
}

- (void)viewWillAppear:(BOOL)animated {
    NSData *gameData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
    self.players = [NSKeyedUnarchiver unarchiveObjectWithData:gameData];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPAScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MPAPlayer *player = [self.players objectAtIndex:indexPath.row];
    
    cell.cellNameLabel.text = player.name;
    cell.cellLevelLabel.text = [NSString stringWithFormat:@"%d",player.level];
    cell.cellGearLabel.text = [NSString stringWithFormat:@"%d",player.gear];
    cell.cellStrengthLabel.text = [NSString stringWithFormat:@"%d",player.strength];
    
    return cell;
}

@end
