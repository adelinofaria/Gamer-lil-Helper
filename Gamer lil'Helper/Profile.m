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
        self.processName = @"";
        self.processPID = @"0";
        self.mouseAcceleration = [NSNumber numberWithFloat:0.687500];
        self.mouseSpeed = [NSNumber numberWithFloat:1];
        self.keyboardKeyRepeat = [NSNumber numberWithFloat:0.083333];
        self.keyboardKeyDelay = [NSNumber numberWithFloat:0.500000];
        self.keyboardFKeys = YES;
    }
    
    return self;
}

- (void)resetProfile {
    self.processName = @"";
    self.processPID = @"0";
    self.mouseAcceleration = [NSNumber numberWithFloat:0.687500];
    self.mouseSpeed = [NSNumber numberWithFloat:1];
    self.keyboardKeyRepeat = [NSNumber numberWithFloat:0.083333];
    self.keyboardKeyDelay = [NSNumber numberWithFloat:0.500000];
    self.keyboardFKeys = YES;
}

+ (NSMutableDictionary *)objectToDictionary:(Profile *)profile {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:profile.name forKey:kName];
    [dictionary setObject:profile.processName forKey:kProcessName];
    [dictionary setObject:profile.processPID forKey:kProcessPID];
    [dictionary setObject:profile.mouseAcceleration forKey:kMouseAcceleration];
    [dictionary setObject:profile.mouseSpeed forKey:kMouseSpeed];
    [dictionary setObject:profile.keyboardKeyRepeat forKey:kKeyboardKeyRepeat];
    [dictionary setObject:profile.keyboardKeyDelay forKey:kKeyboardKeyDelay];
    [dictionary setObject:[NSNumber numberWithBool:profile.keyboardFKeys] forKey:kKeyboardFKeys];
    
    return dictionary;
}

+ (Profile *)dictionaryToObject:(NSDictionary *)dictionary {
    Profile *profile = [[Profile alloc] init];
    
    profile.name = [dictionary objectForKey:kName];
    profile.processName = [dictionary objectForKey:kProcessName];
    profile.processPID = [dictionary objectForKey:kProcessPID];
    profile.mouseAcceleration = [dictionary objectForKey:kMouseAcceleration];
    profile.mouseSpeed = [dictionary objectForKey:kMouseSpeed];
    profile.keyboardKeyRepeat = [dictionary objectForKey:kKeyboardKeyRepeat];
    profile.keyboardKeyDelay = [dictionary objectForKey:kKeyboardKeyDelay];
    profile.keyboardFKeys = [[dictionary objectForKey:kKeyboardFKeys] boolValue];
    
    return profile;
}

@end
