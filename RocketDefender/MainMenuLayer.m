//
//  MainMenuLayer.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "RocketDefenderLayer.h"

@implementation MainMenuLayer

+(CCScene *)scene {
    CCScene *scene = [CCScene node];
    MainMenuLayer *layer = [MainMenuLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init {
    if(self = [super init]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Backdrop
        _backdrop = [CCSprite spriteWithFile:@"MainMenuBackdrop.png"];
        _backdrop.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_backdrop];
        
        // Play Game Button
        _playButton = [CCSprite spriteWithFile:@"PlayButton.png"];
        _playButton.position = ccp(winSize.width/2+15, winSize.height/2+50);
        [self addChild:_playButton];
        
        self.isTouchEnabled = YES;
    }
    return self;
}

-(void)dealloc {
    [_playButton release];
    _playButton = nil;
    
    [_backdrop release];
    _backdrop = nil;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Get touch coordinates
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if( (location.x < _playButton.position.x + _playButton.contentSize.width/2) &&
        (location.x > _playButton.position.x - _playButton.contentSize.width/2) &&
        (location.y < _playButton.position.y + _playButton.contentSize.height/2) &&
        (location.y > _playButton.position.y - _playButton.contentSize.height/2)) {
        
        [[CCDirector sharedDirector] replaceScene:[RocketDefenderLayer scene]];
    }
}
@end
