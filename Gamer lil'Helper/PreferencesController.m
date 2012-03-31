//
//  PreferencesController.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/22/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "PreferencesController.h"
#import "Profile.h"

static PreferencesController *sharedInstance = nil;

@interface PreferencesController (Private)

- (void)copyLoginItems:(LSSharedFileListRef *)loginItems andCurrentLoginItem:(LSSharedFileListItemRef *)currentItem;

@end

@implementation PreferencesController

@synthesize profiles = _profiles;
@synthesize shouldRunAtStart = _shouldRunAtStart;
@synthesize shouldCheckUpdates = _shouldCheckUpdates;
@synthesize shouldShowNotifications = _shouldShowNotifications;

@synthesize lastUpdateCheck = _lastUpdateCheck;

+ (PreferencesController *)sharedInstance {
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[PreferencesController alloc] init];
    }
    
    return sharedInstance;
}

- (void)setPreferencesDefaults {
    [[NSUserDefaults standardUserDefaults] setBool:self.shouldRunAtStart forKey:@"applicationStartupCheckbox"];
    [[NSUserDefaults standardUserDefaults] setBool:self.shouldCheckUpdates forKey:@"applicationUpdateCheckbox"];
    [[NSUserDefaults standardUserDefaults] setBool:self.shouldShowNotifications forKey:@"desktopNotificationsCheckbox"];
    
    [self savePreferences];
}

- (void)setupPreferences {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstRun"]) {
        [self setPreferencesDefaults];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstRun"];
    }
    
    if ([self existsInStartupItems])
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"shouldStartAtLogin"];
    else
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"shouldStartAtLogin"];
    
    if (self.shouldRunAtStart)
        [self loadAtStartup:YES];
}

- (void)savePreferences {
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        Log(@"Successfully wrote preferences to disk.");
    } else {
        Log(@"Failed to write preferences to disk.");
    }
}

- (void)addProfile:(Profile *)profile {
    [_profiles addObject:profile];
}

- (void)removeProfile:(Profile *)profile {
    [_profiles removeObject:profile];
}

- (void)resetProfile {
    
}

- (void)copyLoginItems:(LSSharedFileListRef *)loginItems andCurrentLoginItem:(LSSharedFileListItemRef *)currentItem {
    *loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
    if (*loginItems) {
        UInt32 seedValue;
        NSArray *loginItemsArray = (__bridge NSArray *)LSSharedFileListCopySnapshot(*loginItems, &seedValue);
        
        for (id item in loginItemsArray) {
            LSSharedFileListItemRef itemRef = (__bridge LSSharedFileListItemRef)item;
            CFURLRef URL = NULL;
            
            if (LSSharedFileListItemResolve(itemRef, 0, &URL, NULL) == noErr) {
                if ([[(__bridge NSURL *)URL path] hasSuffix:@"gfxCardStatus.app"]) {
                    Log(@"Exists in startup items.");
                    
                    *currentItem = (__bridge LSSharedFileListItemRef)item;
                    CFRetain(*currentItem);
                    
                    CFRelease(URL);
                    
                    break;
                }
                
                CFRelease(URL);
            }
        }
    }
}

- (BOOL)existsInStartupItems {
    BOOL exists;
    LSSharedFileListRef loginItems = NULL;
    LSSharedFileListItemRef currentItem = NULL;
    
    [self copyLoginItems:&loginItems andCurrentLoginItem:&currentItem];
    
    exists = (currentItem != NULL);
    
    if (loginItems != NULL)
        CFRelease(loginItems);
    if (currentItem != NULL)
        CFRelease(currentItem);
    
    return exists;
}

- (void)loadAtStartup:(BOOL)value {
    NSURL *thePath = [[NSBundle mainBundle] bundleURL];
    LSSharedFileListRef loginItems = NULL;
    LSSharedFileListItemRef currentItem = NULL;
    
    [self copyLoginItems:&loginItems andCurrentLoginItem:&currentItem];
    
    if (loginItems) {
        if (value && currentItem == NULL) {
            Log(@"Adding to startup items.");
            LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemBeforeFirst, NULL, NULL, (__bridge CFURLRef)thePath, NULL, NULL);
            if (item) CFRelease(item);
        } else if (!value && currentItem != NULL) {
            Log(@"Removing from startup items.");        
            LSSharedFileListItemRemove(loginItems, currentItem);
        }
        
        CFRelease(loginItems);
        if (currentItem)
            CFRelease(currentItem);
    }
}

@end
