//
//  MPAScoreTableViewCell.h
//  MunchkinCounter
//
//  Created by Matt Pearce on 9/15/15.
//  Copyright (c) 2015 MPApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPAScoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellGearLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellStrengthLabel;

@end
