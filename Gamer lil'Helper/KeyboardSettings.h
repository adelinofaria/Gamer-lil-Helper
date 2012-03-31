//
//  KeyboardSettings.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardSettings : NSObject

+ (double)getKeyRepeatInterval;
+ (void)setKeyRepeatInterval:(double)seconds;
+ (double)getKeyRepeatThreshold;
+ (void)setKeyRepeatThreshold:(double)threshold;
+ (int)getFnKeyMode;
+ (BOOL)setFnKeyMode:(int)mode;

+ (void)resetKeyboardSettings;

@end
