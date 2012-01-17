//
//  Turret.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Turret.h"

@implementation Turret
@synthesize sprite = _sprite;
@synthesize caller = _caller;
@synthesize projectile = _projectile;

-(id)initWithCaller:(CCLayer *)caller {
    if(self = [super init]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.sprite = [CCSprite spriteWithFile:@"Turret.png"];
        self.sprite.position = ccp(winSize.width/2, self.sprite.contentSize.height/2);
        self.caller = caller;
        self.projectile = nil;
    }
    return self;
}

-(CCSprite *)fireProjectile:(CGPoint)touchLocation {
    
    // If middle-fire for another touch; abort
    if(self.projectile!=nil) return nil;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Create projectile with sprite and initial location
    self.projectile = [CCSprite spriteWithFile:@"Projectile.png"];
    self.projectile.position = ccp(winSize.width/2, self.sprite.contentSize.height/2);
    
    // Find out how many degrees to rotate turret (and speed)
    float xOffset = touchLocation.x - self.sprite.position.x;
    float yOffset = touchLocation.y - self.sprite.position.y;
    float angleInRadians = fabsf(atanf(xOffset/yOffset));
    float angleInDegrees = CC_RADIANS_TO_DEGREES(angleInRadians);
    float cocosConfiguredAngle = angleInDegrees;
    if(touchLocation.x < self.sprite.position.x) cocosConfiguredAngle *= -1;
    float rotationVelocity = 1 / 2*(2*M_PI); // 2 rotations per second
    float rotateDuration = rotationVelocity * angleInRadians;
    
    // Find out where to shoot projectile
    float m = yOffset/xOffset;
    float b = self.sprite.position.x;
    float y = winSize.height + 3;
    float x = (1/m)*y + b;
    
    // Calculates speed of the projectile
    float distance = sqrtf((yOffset*yOffset)+(xOffset*xOffset));
    float moveDuration = distance / 480;
    
    // Rotate the turret and then fire the projectile
    [self.sprite runAction:[CCSequence actions:
                            [CCRotateTo actionWithDuration:rotateDuration angle:cocosConfiguredAngle],
                            [CCCallFunc actionWithTarget:self selector:@selector(finishShot)],
                            nil]];
    
    [self.projectile runAction:[CCSequence actions:
                                [CCMoveTo actionWithDuration:moveDuration position:ccp(x, y)],
                                [CCCallFunc actionWithTarget:self selector:@selector(spriteDone:)],
                                nil]];
    
    // Return projectile master layer's records
    return self.projectile;
}

-(void)finishShot {
    [self.caller addChild:self.projectile];
    
    [self.projectile release];
    self.projectile = nil;
}

-(void)spriteDone:(id)sender {
    sender = (CCSprite *)sender;
    [self.caller removeChild:sender cleanup:YES];
}

@end
