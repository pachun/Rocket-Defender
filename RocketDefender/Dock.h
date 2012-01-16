//
//  Dock.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface Dock : NSObject {
    bool _active;
    CCSprite *_sprite;
}
@property(nonatomic)bool active;
@property(retain, nonatomic)CCSprite *sprite;

-(id)initActive;
-(CGPoint)dockingPoint;
-(void)dealloc;
@end
