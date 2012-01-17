//
//  MainMenuLayer.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainMenuLayer : CCLayer {
    CCSprite *_playButton;
    
    CCSprite *_backdrop;
}

+(CCScene *)scene;
@end
