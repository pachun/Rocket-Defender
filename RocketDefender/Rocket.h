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

#define RocketHeight 60
#define RocketWidth  36

@interface Rocket : NSObject {
    CCSprite *_sprite;
    Dock *_dock;
    int _level;
    int _armor;
}
@property(nonatomic)int armor;
@property(nonatomic)int level;
@property(retain, nonatomic)Dock *dock;
@property(retain, nonatomic)CCSprite *sprite;

-(id)spawnWithLevel:(int)level andTargetDocks:(NSMutableArray *)docks to:(CCLayer *)layer;
-(void)setStartingLocationForLevel:(int)lvl;
-(void)targetClosestDock:(NSMutableArray *)docks;
-(void)dealloc;
@end
