//
//  Profile.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kName @"Name"
#define kProcessName @"ProcessName"
#define kProcessPID @"ProcessPID"
#define kMouseAcceleration @"MouseAcceleration"
#define kMouseSpeed @"MouseSpeed"
#define kKeyboardKeyRepeat @"KeyboardKeyRepeat"
#define kKeyboardKeyDelay @"KeyboardKeyDelay"
#define kKeyboardFKeys @"KeyboardFKeys"

@interface Profile : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *processName;
@property (nonatomic, retain) NSString *processPID;
@property (nonatomic, retain) NSNumber *mouseAcceleration;
@property (nonatomic, retain) NSNumber *mouseSpeed;
@property (nonatomic, retain) NSNumber *keyboardKeyRepeat;
@property (nonatomic, retain) NSNumber *keyboardKeyDelay;
@property (nonatomic) BOOL keyboardFKeys;

- (id)initWithName:(NSString *)name;

- (void)resetProfile;

+ (NSMutableDictionary *)objectToDictionary:(Profile *)profile;
+ (Profile *)dictionaryToObject:(NSDictionary *)dictionary;

@end
