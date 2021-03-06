//
//  Car.m
//  DriftForever
//
//  Created by Adawat Chanchua on 10/1/55 BE.
//
//

#import "Car.h"
#import "Utils.h"

// ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
@interface CarCache: NSObject

@property (retain) CCSprite*    carSprite;
@property (assign) CGPoint      position;
@property (assign) CGFloat      rotation;
@property (assign) CGPoint      target;
@property (assign) float        speed;

@end
@implementation CarCache
@synthesize carSprite;
@synthesize position;
@synthesize rotation;
@synthesize target;
@synthesize speed;

- (id) init
{
    self    = [super init];
    if (self)
    {
        carSprite   = NULL;
        position    = CGPointMake(0.0f, 0.0f);
        rotation    = 0.0f;
        target      = CGPointMake(0.0f, 0.0f);
        speed       = 1.0f;
    }
    return self;
}
- (void) dealloc
{
    [super dealloc];
}
@end

CarCache* _carCache = nil;

// ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
@implementation Car

+ (BOOL) LoadData
{
    // init cache
    _carCache   = [[CarCache alloc] init];
    
    // init car sprite
    _carCache.carSprite   = [CCSprite spriteWithFile:@"car_01_01_Run001.png"];
    [_carCache.carSprite setRotation:0.0f];
    
    CGFloat carScale    = _carCache.carSprite.scale;
    carScale    = [UtilVec convertScaleIfRetina:carScale];
    [_carCache.carSprite setScale:carScale];
    
    return YES;
}

+ (BOOL) UnloadData
{
    // @TODO Next
    
    [_carCache release];
    _carCache   = nil;
    
    return YES;
}

+ (BOOL) AssignDataToLayer: (CCLayer*) layer withMission: (Mission*) mission
{
    [layer addChild:_carCache.carSprite];
    return YES;
}

+ (BOOL) UnSssignDataFromLayer: (CCLayer*) layer
{

    return YES;
}

#pragma mark - Reutines

+ (float) getSpeed
{
    return _carCache.speed;
}

+ (void) setSpeed: (float) speed
{
    _carCache.speed = speed;
}

+ (void) setPosition: (CGPoint&) position
{
    _carCache.position  = position;
    [_carCache.carSprite setPosition:position];
}

+ (void) setTarget: (CGPoint&) target
{
    float deltaX    = target.x - _carCache.position.x;
    float deltaY    = target.y - _carCache.position.y;
    _carCache.target    = target;

    float radian    = atan2f(deltaY, deltaX);
    radian  = M_PI_2 - radian;
    float rotation  = (radian * 180.0f / M_PI );
    
    _carCache.rotation  = rotation;
    [_carCache.carSprite setRotation:rotation];
}

+ (const CGPoint) getPosition
{
    return _carCache.position;
}

+ (const CGFloat) getRotation
{
    return _carCache.rotation;
}

+ (const CGPoint) getTarget
{
    return _carCache.target;
}

@end
