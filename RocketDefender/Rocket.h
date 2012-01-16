//
//  Rocket.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "Dock.h"

@interface Rocket : NSObject {
    CCSprite *_sprite;
    Dock *_dock;
    int _level;
}
@property(nonatomic)int level;
@property(retain, nonatomic)Dock *dock;
@property(retain, nonatomic)CCSprite *sprite;

@end
