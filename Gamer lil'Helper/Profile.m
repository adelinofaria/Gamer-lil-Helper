//
//  Profile.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "Profile.h"

@interface Profile (Private)

- (id)init;

@end

@implementation Profile

@synthesize name = _name;
@synthesize processName = _processName;
@synthesize processPID = _processPID;
@synthesize mouseAcceleration = _mouseAcceleration;
@synthesize mouseSpeed = _mouseSpeed;
@synthesize keyboardKeyRepeat = _keyboardKeyRepeat;
@synthesize keyboardKeyDelay = _keyboardKeyDelay;
@synthesize keyboardFKeys = _keyboardFKeys;

- (id)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.mouseAcceleration = [NSNumber numberWithFloat:0.687500];
        self.mouseSpeed = [NSNumber numberWithFloat:1];
        self.keyboardKeyRepeat = [NSNumber numberWithFloat:0.083333];
        self.keyboardKeyDelay = [NSNumber numberWithFloat:0.500000];
        self.keyboardFKeys = YES;
    }
    
    return self;
}

@end
