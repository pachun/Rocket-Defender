//
//  Dock.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dock.h"
#import "Rocket.h"

@implementation Dock
@synthesize active = _active;
@synthesize sprite = _sprite;

// Initialize the dock to an active state with the given sprite
-(id)initActive {
    if(self = [super init]) {
        self.active = YES;
        self.sprite = [CCSprite spriteWithFile:@"LandingDock.png"];
    }
    return self;
}

// Return the point to configure a rocket to it's landing position
-(CGPoint)dockingPoint {
    return ccp(self.sprite.position.x, self.sprite.position.y+
               self.sprite.contentSize.height/2+
               RocketHeight/2 + 20);
}

-(CGPoint)dockedPoint {
    return ccp(self.sprite.position.x, self.sprite.position.y+
               self.sprite.contentSize.height/2+
               RocketHeight/2 - 10);
}

// Release retained instance vars
-(void)dealloc {
    [self.sprite release];
    self.sprite = nil;
    
    [super dealloc];
}

@end
