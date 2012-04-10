//
//  PreferencesController.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFirstRun @"FirstRun"
#define kApplicationRunAtStart @"ApplicationRunAtStart"
#define kApplicationChecksForUpdates @"ApplicationChecksForUpdates"
#define kShowDesktopNotification @"ShowDesktopNotification"
#define kProfileCount @"ProfileCount"
#define kProfileSelected @"ProfileSelected"
#define kDefaultProfile @"DefaultProfile"

@class Profile;

@interface PreferencesController : NSObject

@property (nonatomic, retain) NSMutableArray *profiles;
@property (nonatomic, retain) Profile *selectedProfile;
@property (nonatomic, retain) Profile *defaultProfile;
@property (nonatomic) BOOL shouldRunAtStart;
@property (nonatomic) BOOL shouldCheckUpdates;
@property (nonatomic) BOOL shouldShowNotifications;

@property (nonatomic, retain) NSDate *lastUpdateCheck;

+ (PreferencesController *)sharedInstance;

- (void)setPreferencesDefaults;
- (void)setupPreferences;
- (void)savePreferences;

- (BOOL)existsInStartupItems;
- (void)loadAtStartup:(BOOL)value;

- (Profile *)selectedProfile;
- (void)addProfile:(Profile *)profile;
- (void)removeProfile:(Profile *)profile;
- (void)resetProfile;

@end
