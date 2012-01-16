//
//  HelloWorldLayer.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface RocketDefenderLayer : CCLayerColor
{
    NSMutableArray *_rockets;
    NSMutableArray *_docks;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
