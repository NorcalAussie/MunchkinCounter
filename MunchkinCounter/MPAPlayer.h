//
//  MPAPlayer.h
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPAPlayer : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int level;
@property (nonatomic) int gear;
@property (nonatomic) int strength;
@property (nonatomic) BOOL isWarrior;

- (id)initWithName:(NSString *)aName;

@end
