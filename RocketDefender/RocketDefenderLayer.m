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
    // Init bg color, baseline scenery sprites, and landing docks...
	if( (self=[super initWithColor:ccc4(77, 243, 241, 255)])) {
        
        // Landing docks
        for(int i = 0; i < 3; i++) {
            
        }
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
