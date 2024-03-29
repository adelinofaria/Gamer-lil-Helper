//
//  MouseSettings.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/4/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "MouseSettings.h"
#import <IOKit/hidsystem/event_status_driver.h>
#import <IOKit/hid/IOHIDKeys.h>
#import <IOKit/hidsystem/IOHIDShared.h>

@implementation MouseSettings

static double default_mouse_acceleration = 0.687500;
static double default_mouse_speed = 1;
// Set the "Tracking Speed" to 1.0. Possible values are 0.0, 0.125, 0.3125, 0.5, 0.6875, 0.875, 1.0, 1.7.

+ (double)getMouseAcceleration {
    NXEventHandle event = NXOpenEventStatus();
    double acceleration;
    kern_return_t kr;
    
    assert(event);
    
    kr = IOHIDGetAccelerationWithKey(event, CFSTR(kIOHIDMouseAccelerationType), &acceleration);
    
    NXCloseEventStatus(event);
    
    if (kr == KERN_SUCCESS)
        return acceleration;
    else
        return -1;
}

+ (BOOL)setMouseAcceleration:(double)value {
    NXEventHandle event = NXOpenEventStatus();
    kern_return_t kr;
    
    kr = IOHIDSetAccelerationWithKey(event, CFSTR(kIOHIDMouseAccelerationType), value);
    
    NXCloseEventStatus(event);
    
    if (kr == KERN_SUCCESS)
        return YES;
    else
        return NO;
}

+ (double)getMouseSpeed {
    
    
    return default_mouse_speed;
}

+ (BOOL)setMouseSpeed:(double)value {
    return NO;
}

+ (BOOL)setDefaultMouseSettings {
    NXEventHandle event = NXOpenEventStatus();
    kern_return_t kr;
    
    //@TODO
    //NXResetMouse(event);
    
    kr = IOHIDSetAccelerationWithKey( event, CFSTR(kIOHIDMouseAccelerationType), default_mouse_acceleration);
    
    NXCloseEventStatus(event);
    
    if (kr == KERN_SUCCESS)
        return YES;
    else
        return NO;
}

@end
