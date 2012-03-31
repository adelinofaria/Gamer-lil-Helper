//
//  KeyboardSettings.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "KeyboardSettings.h"
#import <IOKit/hidsystem/event_status_driver.h>
#import <IOKit/hid/IOHIDKeys.h>
#import <IOKit/hidsystem/IOHIDShared.h>

@implementation KeyboardSettings

//static double defaultKeyRepeatInterval = 0.033333;
//static double defaultKeyRepeatThreshold = 0.583333;
//static double defaultKeyRepeatIntervalReseted = 0.083333;
//static double defaultKeyRepeatThresholdReseted = 0.500000;

+ (double)getKeyRepeatInterval {
    NXEventHandle event = NXOpenEventStatus();
    assert(event);
    
    double value = NXKeyRepeatInterval(event);
    
    NXCloseEventStatus(event);
    
    return value;
}

+ (void)setKeyRepeatInterval:(double)seconds {
    NXEventHandle event = NXOpenEventStatus();
    
    NXSetKeyRepeatInterval(event, seconds);
    
    NXCloseEventStatus(event);
}

+ (double)getKeyRepeatThreshold {
    NXEventHandle event = NXOpenEventStatus();
    assert(event);
    
    double value =  NXKeyRepeatThreshold(event);
    
    NXCloseEventStatus(event);
    
    return value;
}

+ (void)setKeyRepeatThreshold:(double)threshold {
    NXEventHandle event = NXOpenEventStatus();
    
    NXSetKeyRepeatThreshold(event, threshold);
    
    NXCloseEventStatus(event);
}

+ (int)getFnKeyMode {
    NXEventHandle event = NXOpenEventStatus();
    unsigned int value, dummy;
    kern_return_t kr;
    
    assert(event);
    
    kr = IOHIDGetParameter(event, CFSTR(kIOHIDFKeyModeKey), sizeof(value), &value, (IOByteCount *) &dummy);
    
    NXCloseEventStatus(event);
    
    if (kr == KERN_SUCCESS)
        return value;
    else
        return -1;
}

+ (BOOL)setFnKeyMode:(int)mode {
    NXEventHandle event = NXOpenEventStatus();
    kern_return_t kr;
    
    assert(event);
    
    kr = IOHIDSetParameter(event, CFSTR(kIOHIDFKeyModeKey), &mode, sizeof(mode));
    
    NXCloseEventStatus(event);
    
    if (kr == KERN_SUCCESS)
        return YES;
    else
        return NO;
}

+ (void)resetKeyboardSettings {
    NXEventHandle event = NXOpenEventStatus();
    
    NXResetKeyboard(event);
    
    NXCloseEventStatus(event);
}

@end
