//
//  HelloWorldLayer.m
//  RocketDefender
//
//  Created by Nick Pachulski on 1/15/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "RocketDefenderLayer.h"
#import "GameOverScene.h"

// HelloWorldLayer implementation
@implementation RocketDefenderLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RocketDefenderLayer *layer = [RocketDefenderLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    // Initialize instance var arrays
    _projectiles = [[NSMutableArray alloc] init];
    _rockets = [[NSMutableArray alloc] init];
    _docks = [[NSMutableArray alloc] init];
    
    // Init bg color, baseline scenery sprites, and landing docks...
	if( (self=[super initWithColor:ccc4(77, 243, 241, 255)])) {
        
        // Landing docks
        for(int i = 1, j = 1; i <= 3; i++, j+=2) {
            Dock *dock = [[Dock alloc] initActive];
            dock.sprite.position = ccp(((i*23)+(dock.sprite.contentSize.width/2*j)), dock.sprite.contentSize.height/2);
            [_docks addObject:dock];
            [self addChild:dock.sprite];
        }
        
        // Clouds and sky
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _clouds = [CCSprite spriteWithFile:@"Clouds.png"];
        _clouds.position = ccp(winSize.width/2, winSize.height-_clouds.contentSize.height/2);
        [self addChild:_clouds];
        
        // Ground
        _ground = [CCSprite spriteWithFile:@"Ground.png"];
        _ground.position = ccp(winSize.width/2, _ground.contentSize.height/2);
        [self addChild: _ground];
        
        // Turret
        _turret = [[Turret alloc] initWithCaller:self];
        [self addChild:_turret.sprite];
        
        // Reset the score
        _points = 0;
        
        // Enable touches
        self.isTouchEnabled = YES;
        
        // Game Logic
        [self schedule:@selector(checkForLose)];
        [self schedule:@selector(redirectRockets)];
        [self schedule:@selector(spawnRocket) interval:2.0];
        
        [self schedule:@selector(detectCollisions)];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [_projectiles release];
    _projectiles = nil;
    [_turret release];
    _turret = nil;
    
	[_rockets release];
    _rockets = nil;
    [_docks release];
    _docks = nil;
    
    [_clouds release];
    _clouds = nil;
    [_ground release];
    _ground = nil;
    [_turret release];
    _turret = nil;
    
	[super dealloc];
}

-(void)spawnRocket {
    
    // Spawn a rocket targetted to it's closest dock
    Rocket *rocket = [[Rocket alloc] spawnWithLevel:1 andTargetDocks:_docks to:self];
    
    // Add it to our rockets array
    [_rockets addObject:rocket];
}

-(void)redirectRockets {
    
    // Redirect any rocket headed towards a dock that is now inactive (has been docked)
    for(Rocket *r in _rockets)
        if(!r.dock.active && r.armor != -1)
            [r targetClosestDock:_docks];
}

-(void)checkForLose {
    
    // If all docks are inactive, you lose
    bool lost = true;
    for(Dock *d in _docks)
        if(d.active) lost = false;
    
    if(lost) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:_points forKey:@"LastScore"];
        
        GameOverScene *gameOverScene = [GameOverScene node];
        _points = 0;
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Get the location of the touch
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Fire a projectile from the turret and save it in our projectiles array
    [_projectiles addObject:[_turret fireProjectile:location]];
}

-(void)detectCollisions {
    
    // Loop thru rockets
    NSMutableArray *rocketsToDelete = [[NSMutableArray alloc] init];
    for(Rocket *r in _rockets) {
        
        // If this rocket is docked, it's not applicable. Skip it.
        if(r.armor==-1) continue;
        
        // Create a rectangle represenation of this sprite
        CGRect rocketRect = CGRectMake(r.sprite.position.x-r.sprite.contentSize.width/2, 
                                       r.sprite.position.y-r.sprite.contentSize.height/2,
                                       r.sprite.contentSize.width, 
                                       r.sprite.contentSize.height);
        
        // Loop thru projectiles
        NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
        for(CCSprite *p in _projectiles) {
            
            // Create a rectangle representation of this sprite
            CGRect projectileRect = CGRectMake(p.position.x-p.contentSize.width/2, 
                                               p.position.y-p.contentSize.height/2, 
                                               p.contentSize.width, p.contentSize.height);
            
            if(CGRectIntersectsRect(rocketRect, projectileRect)) {
                [projectilesToDelete addObject:p];
            }
        }
        
        // Delete any projectiles that had a collision
        for(CCSprite *p in projectilesToDelete) {
            [_projectiles removeObject:p];
            [self removeChild:p cleanup:YES];
        }
        
        if([projectilesToDelete count] > 0)
            [rocketsToDelete addObject:r];
        
//        [projectilesToDelete release];   // I have no idea why this line receives a bad exec signal
    }
    
    for(Rocket *r in rocketsToDelete) {
        
        // Delete weak rockets that had a collision
        if(r.armor == 1) {
            [_rockets removeObject:r];
            [self removeChild:r.sprite cleanup:YES];
            _points++;
        
        // Remove armor of strong rockets that had a collision
        } else [r removeArmor];
    }
    
    [rocketsToDelete release];
}

@end
