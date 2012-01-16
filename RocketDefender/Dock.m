//
//  Dock.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dock.h"

@implementation Dock
@synthesize active;
@synthesize sprite;

// Initialize the dock to an active state with the given sprite
-(id)initActiveWithSprite:(NSString *)s {
    if(self = [super init]) {
        self.active = YES;
        self.sprite = [CCSprite spriteWithFile:s];
    }
    return self;
}

// Release retained instance vars
-(void)dealloc {
    [self.sprite release];
    self.sprite = nil;
}

@end
