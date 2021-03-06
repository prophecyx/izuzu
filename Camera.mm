//
//  Camera.m
//  DriftForever
//
//  Created by Adawat Chanchua on 10/1/55 BE.
//
//

#import "Camera.h"

Camera* _object = nil;

@interface Camera()

@property (assign) CCLayer*     _layer;
@property (assign) BOOL         _isZooming;
@property (assign) CGPoint      _layerRefPoint;
@property (assign) CGFloat      _zoomX;
@property (assign) CGPoint      _layerZoomPoint;

@end

@implementation Camera
@synthesize _layer;
@synthesize _isZooming;
@synthesize _layerRefPoint;
@synthesize _zoomX;
@synthesize _layerZoomPoint;

+ (Camera*) getObject
{
    if ( ! _object )
    {
        _object                 = [[Camera alloc] init];
        _object._isZooming      = NO;
        _object._layerRefPoint  = _object._layer.position;
        _object._zoomX          = 1.0f;
    }
    
    return _object;
}

- (void) initCameraWithLayer: (CCLayer*) layer
{
    _object._layer  = layer;
}

- (void) moveCameraByPoint: (CGPoint) point
{
    CGPoint layerAbsPoint;
    
    // move camera
    _layerRefPoint  = CGPointMake(_layerRefPoint.x + point.x,
                                  _layerRefPoint.y + point.y);
    layerAbsPoint   = _layerRefPoint;
    
    // set zoom
    [_object zoomTo:_object._zoomX];
    
    // set to layer
    //CCLayer* layer  = _object._layer;
    //[layer setPosition:layerAbsPoint];
}

- (void) setCameraToPoint: (CGPoint) point
{
    CGPoint layerAbsPoint;
    
    // move camera
    _layerRefPoint  = CGPointMake(-point.x, -point.y);
    layerAbsPoint   = _layerRefPoint;
    
    // set zoom
    [_object zoomTo:_object._zoomX];
    
    // set to layer
    //[layer setPosition:layerAbsPoint];
}

- (CGPoint) getPoint
{
    return _object._layerRefPoint;
}

- (CGFloat) getZoomX
{
    return _object._zoomX;
}

- (void) zoomTo: (CGFloat) zoomX
{
    // set vars
    _object._zoomX  = zoomX;

    // set zoom
    Camera* object  = [Camera getObject];
    CCLayer* layer  = object._layer;
    [layer setScale:zoomX];
    
    // adjust layer
    _layerZoomPoint   = CGPointMake(object._layerRefPoint.x * object._zoomX,
                                    object._layerRefPoint.y * object._zoomX);

    [layer setPosition:_layerZoomPoint];
}

- (void) onUpdate: (float) deltaTime
{
}

@end
