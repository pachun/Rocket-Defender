//
//  HelloWorldLayer.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "Dock.h"
#import "Rocket.h"
#import "Turret.h"

// HelloWorldLayer
@interface RocketDefenderLayer : CCLayerColor
{
    NSMutableArray *_projectiles;
    NSMutableArray *_rockets;
    NSMutableArray *_docks;
    CCSprite *_clouds;
    CCSprite *_ground;
    Turret *_turret;
    int _points;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
