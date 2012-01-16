//
//  Rocket.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Rocket.h"

@implementation Rocket
@synthesize level;
@synthesize dock;
@synthesize sprite;

// Release retained instance vars
-(void)dealloc {
    [self.sprite release];
    self.sprite = nil;
    [self.dock release];
    self.dock = nil;
}

@end
