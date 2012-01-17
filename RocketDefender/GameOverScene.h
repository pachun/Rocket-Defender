//
//  GameOverScene.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
    CCLabelTTF *_gameOver;
    CCLabelTTF *_topScore;
    CCLabelTTF *_lastScore;
}
@property(nonatomic, retain)CCLabelTTF *gameOver;
@property(nonatomic, retain)CCLabelTTF *topScore;
@property(nonatomic, retain)CCLabelTTF *lastScore;
@end

@interface GameOverScene : CCScene {
    GameOverLayer *_layer;
}
@property(nonatomic, retain)CCLayer *layer;
@end
