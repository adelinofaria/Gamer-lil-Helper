//
//  MouseSettings.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/4/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MouseSettings : NSObject

+ (double)getMouseAcceleration;
+ (BOOL)setMouseAcceleration:(double)value;
+ (double)getMouseSpeed;
+ (BOOL)setMouseSpeed:(double)value;

+ (BOOL)setDefaultMouseSettings;

@end
