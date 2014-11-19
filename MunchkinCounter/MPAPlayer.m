//
//  MPAPlayer.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import "MPAPlayer.h"

@implementation MPAPlayer

- (id)initWithName:(NSString *)aName{
    self = [super init];
    
    if(self){
        self.name = aName;
        self.level = 1;
        self.gear = 0;
        self.strength = 1;
        self.isWarrior = false;
        
    }
    return self;
    
}

@end
