//
//  Turret.h
//  RocketDefender
//
//  Created by Nick Pachulski on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Turret : NSObject {
    CCLayer *_caller;
    CCSprite *_sprite;
    CCSprite *_projectile;
}
@property(retain, nonatomic)CCLayer *caller;
@property(retain, nonatomic)CCSprite *sprite;
@property(retain, nonatomic)CCSprite *projectile;

-(id)initWithCaller:(CCLayer *)caller;
-(CCSprite *)fireProjectile:(CGPoint)touchLocation;
-(void)finishShot;
-(void)spriteDone:(id)sender;
@end
