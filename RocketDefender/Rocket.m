//
//  Rocket.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Rocket.h"

@implementation Rocket

@synthesize level = _level;
@synthesize armor = _armor;
@synthesize landingDegrees = _landingDegrees;
@synthesize dock = _dock;
@synthesize sprite = _sprite;

-(id)spawnWithLevel:(int)lvl andTargetDocks:(NSMutableArray *)docks to:(CCLayer *)gameLayer {
    
    if(self = [super init]) {
        
        // Create armor strength (1/5 it will be 2; otherwise it will be 1)
        int armorDie = arc4random() % 4 + 1;
        if(armorDie == 1) self.armor = 2;
        else self.armor = 1;
        
        // Create the sprite (different image based on armor level)
        if(self.armor == 2) self.sprite = [CCSprite spriteWithFile:@"RedRocket.png"];
        else self.sprite = [CCSprite spriteWithFile:@"BlueRocket.png"];
        
        // Create starting location based on the level
        [self setStartingLocationForLevel: lvl];
        
        // Add the rocket to the game layer
        [gameLayer addChild:self.sprite];
        
        // Send it off!
        [self targetClosestDock:docks];
    }
    return self;
}

-(void)setStartingLocationForLevel:(int)lvl {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Spawn directly above the layer for level one
    if(lvl == 1) {
        int xMin = RocketWidth/2;
        int xMax = winSize.width - RocketWidth/2;
        int xRange = xMax - xMin;
        
        int xPos = arc4random() % xRange + xMin;
        int yPos = winSize.height + RocketHeight/2;
        self.sprite.position = ccp(xPos, yPos);
    }
}

-(void)targetClosestDock:(NSMutableArray *)docks {
    
    // Locate and set a course for the closest docking station
    int leastDist = 1000;
    for(Dock *d in docks)
        if( d.active )
            if( fabs(self.sprite.position.x-d.sprite.position.x) < leastDist ) {
                leastDist = fabs(self.sprite.position.x-d.sprite.position.x);
                self.dock = d;
            }
    
    // Determine angle to turn and face the dock
    float xOffset = fabsf(self.sprite.position.x-self.dock.sprite.position.x);
    float yOffset = fabsf(self.sprite.position.y-self.dock.sprite.position.y);
    float angleInRadians = atanf(xOffset/yOffset);
    float angleInDegrees = CC_RADIANS_TO_DEGREES(angleInRadians);
    float cocosConfiguredAngle = angleInDegrees;
    if(self.sprite.position.x < self.dock.sprite.position.x) cocosConfiguredAngle *= -1;
    self.landingDegrees = 180 + angleInDegrees;
    
    // Determine a duration to the docking points [2,4] seconds
    float duration = arc4random() % 2 + 2;
    
    // Face the rocket to the dock, and shoot it towards the docking point
    [self.sprite runAction:[CCSequence actions:
                            [CCRotateTo actionWithDuration:.001 angle:cocosConfiguredAngle],
                            [CCMoveTo actionWithDuration:duration position:self.dock.dockingPoint],
                            [CCCallFunc actionWithTarget:self selector:@selector(rotateAndLand)],
                            nil]];
}

-(void)rotateAndLand {
    
    // Inactive the dock
    self.dock.active = NO;
    
    // Make the rocket invincible
    self.armor = -1;
    
    // Rotate and land the rocket
    [self.sprite runAction:[CCSequence actions:
                            [CCRotateTo actionWithDuration:0.3 angle:self.landingDegrees],
                            [CCMoveTo actionWithDuration:1.0 position:self.dock.dockedPoint],
                            nil]];
}

// Release retained instance vars
-(void)dealloc {
    [self.sprite release];
    self.sprite = nil;
    [self.dock release];
    self.dock = nil;
    
    [super dealloc];
}

@end
