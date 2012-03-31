//
//  PreferencesController.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Profile;

@interface PreferencesController : NSObject

@property (nonatomic, retain) NSMutableArray *profiles;
@property (nonatomic) BOOL shouldRunAtStart;
@property (nonatomic) BOOL shouldCheckUpdates;
@property (nonatomic) BOOL shouldShowNotifications;

@property (nonatomic, retain) NSDate *lastUpdateCheck;

+ (PreferencesController *)sharedInstance;

- (NSString *)getPreferencesPath;
- (void)setPreferencesDefaults;
- (void)setupPreferences;
- (void)savePreferences;

- (BOOL)existsInStartupItems;
- (void)loadAtStartup:(BOOL)value;

- (void)addProfile:(Profile *)profile;
- (void)removeProfile:(Profile *)profile;
- (void)resetProfile;

@end
