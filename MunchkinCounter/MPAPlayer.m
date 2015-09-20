//
//  MPAPlayer.m
//  MunchkinCounter
//
//  Created by Matt Pearce on 11/19/14.
//  Copyright (c) 2014 MPApps. All rights reserved.
//

#import "MPAPlayer.h"

@implementation MPAPlayer

- (id)initWithName:(NSString *)aName {
    self = [super init];
    
    if(self) {
        self.name = aName;
        self.level = 1;
        self.gear = 0;
        self.strength = 1;
        self.isWarrior = false;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.level = [aDecoder decodeDoubleForKey:@"level"];
        self.gear = [aDecoder decodeDoubleForKey:@"gear"];
        self.strength = [aDecoder decodeDoubleForKey:@"strength"];
        self.isWarrior = [aDecoder decodeBoolForKey:@"isWarrior"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeDouble:_level forKey:@"level"];
    [aCoder encodeDouble:_gear forKey:@"gear"];
    [aCoder encodeDouble:_strength forKey:@"strength"];
    [aCoder encodeBool:_isWarrior forKey:@"isWarrior"];
}

@end
