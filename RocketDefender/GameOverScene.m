//
//  GameOverScene.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "GameOverScene.h"
#import "RocketDefenderLayer.h"

@implementation GameOverScene
@synthesize layer = _layer;

-(id)init {
    if(self = [super init]) {
        self.layer = [GameOverLayer node];
        [self addChild:_layer];
    }
    return self;
}

-(void)dealloc {
    [_layer release];
    _layer = nil;
    
    [super dealloc];
}
@end

@implementation GameOverLayer
@synthesize gameOver = _gameOver;
@synthesize topScore = _top;
@synthesize lastScore = _lastScore;

-(id)init {
    if(self = [super initWithColor:ccc4(0, 0, 0, 255)]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // Game over label
        _gameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Arial" fontSize:32];
        _gameOver.color = ccc3(255, 255, 255);
        _gameOver.position = ccp(winSize.width/2, winSize.height/2+_gameOver.contentSize.height/2+50);
        [self addChild:_gameOver];
        
        // Top score label
        _topScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Top Score: %i", 
                                                 [prefs integerForKey:@"TopScore"]] 
                                       fontName:@"Arial" fontSize:18];
        _topScore.color = ccc3(255, 255, 255);
        _topScore.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_topScore];
        
        // Last score label
        _lastScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Last Score: %i", 
                                                 [prefs integerForKey:@"LastScore"]] 
                                       fontName:@"Arial" fontSize:18];
        _lastScore.color = ccc3(255, 255, 255);
        _lastScore.position = ccp(winSize.width/2, winSize.height/2-_topScore.contentSize.height/2-20);
        [self addChild:_lastScore];
        
        // Reset the high score if necessary
        if([prefs integerForKey:@"LastScore"] > [prefs integerForKey:@"TopScore"])
            [prefs setInteger:[prefs integerForKey:@"LastScore"] forKey:@"TopScore"];
        
        // Show this for 3 seconds before returning to the home screen
        [self runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:3.0],
                         [CCCallFuncN actionWithTarget:self selector:@selector(redirectToHomeScreen)],
                         nil]];
    }
    return self;
}

-(void)redirectToHomeScreen {
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

-(void)dealloc {
    [self.gameOver release];
    _gameOver = nil;
    [self.topScore release];
    _topScore = nil;
    [self.lastScore release];
    _lastScore = nil;
}

@end