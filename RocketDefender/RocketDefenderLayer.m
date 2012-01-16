//
//  HelloWorldLayer.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "RocketDefenderLayer.h"

// HelloWorldLayer implementation
@implementation RocketDefenderLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RocketDefenderLayer *layer = [RocketDefenderLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    // Initialize instance var arrays
    _rockets = [[NSMutableArray alloc] init];
    _docks = [[NSMutableArray alloc] init];
    
    // Init bg color, baseline scenery sprites, and landing docks...
	if( (self=[super initWithColor:ccc4(77, 243, 241, 255)])) {
        
        // Landing docks
        for(int i = 1, j = 1; i <= 3; i++, j+=2) {
            Dock *dock = [[Dock alloc] initActive];
            dock.sprite.position = ccp(((i*23)+(dock.sprite.contentSize.width/2*j)), dock.sprite.contentSize.height/2);
            [_docks addObject:dock];
            [self addChild:dock.sprite];
        }
        
        // Clouds and sky
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _clouds = [CCSprite spriteWithFile:@"Clouds.png"];
        _clouds.position = ccp(winSize.width/2, winSize.height-_clouds.contentSize.height/2);
        [self addChild:_clouds];
        
        // Ground
        _ground = [CCSprite spriteWithFile:@"Ground.png"];
        _ground.position = ccp(winSize.width/2, _ground.contentSize.height/2);
        [self addChild: _ground];
        
        // Game Logic
        [self schedule:@selector(checkForLose)];
        [self schedule:@selector(redirectRockets)];
        [self schedule:@selector(spawnRocket) interval:2.0];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[_rockets release];
    _rockets = nil;
    [_docks release];
    _docks = nil;
    
    [_clouds release];
    _clouds = nil;
    [_ground release];
    _ground = nil;
    
	[super dealloc];
}

-(void)spawnRocket {
    
    // Spawn a rocket targetted to it's closest dock
    Rocket *rocket = [[Rocket alloc] spawnWithLevel:1 andTargetDocks:_docks to:self];
    
    // Add it to our rockets array
    [_rockets addObject:rocket];
}

-(void)redirectRockets {
    
    // Redirect any rocket headed towards a dock that is now inactive (has been docked)
    for(Rocket *r in _rockets)
        if(!r.dock.active && r.armor != -1)
            [r targetClosestDock:_docks];
}

-(void)checkForLose {
    
    // If all docks are inactive, you lose
    bool lost = true;
    for(Dock *d in _docks)
        if(d.active) lost = false;
    
    if(lost) {
        // YOU LOSE CODE
    }
}

@end
