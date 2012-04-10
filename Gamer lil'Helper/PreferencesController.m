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
@synthesize selectedProfile = _selectedProfile;
@synthesize defaultProfile = _defaultProfile;
@synthesize shouldRunAtStart = _shouldRunAtStart;
@synthesize shouldCheckUpdates = _shouldCheckUpdates;
@synthesize shouldShowNotifications = _shouldShowNotifications;

@synthesize lastUpdateCheck = _lastUpdateCheck;

+ (PreferencesController *)sharedInstance {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[PreferencesController alloc] init];
            [sharedInstance setupPreferences];
        }
    }
    
    return sharedInstance;
}

- (void)setPreferencesDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.defaultProfile = [[Profile alloc] initWithName:@"Default"];
    
    [userDefaults setBool:self.shouldRunAtStart forKey:kApplicationRunAtStart];
    [userDefaults setBool:self.shouldCheckUpdates forKey:kApplicationChecksForUpdates];
    [userDefaults setBool:self.shouldShowNotifications forKey:kShowDesktopNotification];
    [userDefaults setObject:[Profile objectToDictionary:self.defaultProfile] forKey:kDefaultProfile];
    [userDefaults setInteger:0 forKey:kProfileCount];
    [userDefaults setInteger:0 forKey:kProfileSelected];
    
    [userDefaults synchronize];
}

- (void)setupPreferences {
    self.profiles = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults boolForKey:kFirstRun]) {
        [self setPreferencesDefaults];
        [userDefaults setBool:YES forKey:kFirstRun];
    }
    
    self.shouldRunAtStart = [userDefaults boolForKey:kApplicationRunAtStart];
    self.shouldCheckUpdates = [userDefaults boolForKey:kApplicationChecksForUpdates];
    self.shouldShowNotifications = [userDefaults boolForKey:kShowDesktopNotification];
    self.defaultProfile =  [Profile dictionaryToObject:[userDefaults objectForKey:kDefaultProfile]];
    [self.profiles addObject:self.defaultProfile];
    
    for (int i = 1; i < [userDefaults integerForKey:kProfileCount]; i++)
        [self.profiles addObject:[Profile dictionaryToObject:[userDefaults objectForKey:[NSString stringWithFormat:@"%i", i]]]];
    
    self.selectedProfile = [_profiles objectAtIndex:[userDefaults integerForKey:kProfileSelected]];
}

- (void)savePreferences {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:self.shouldRunAtStart forKey:kApplicationRunAtStart];
    [userDefaults setBool:self.shouldCheckUpdates forKey:kApplicationChecksForUpdates];
    [userDefaults setBool:self.shouldShowNotifications forKey:kShowDesktopNotification];
    [userDefaults setObject:[Profile objectToDictionary:[[Profile alloc] initWithName:@"Default"]] forKey:kDefaultProfile];
    [userDefaults setInteger:[_profiles count] forKey:kProfileCount];
    
    if ([_profiles count] > 1)
        for (int i = 1; i < [_profiles count]; i++)
            [userDefaults setObject:[Profile objectToDictionary:[_profiles objectAtIndex:i]] forKey:[NSString stringWithFormat:@"%i", i]];
    
    //TODO Fix problems with memory references
    if ([_profiles indexOfObject:self.selectedProfile] == NSNotFound)
        [userDefaults setInteger:0 forKey:kProfileSelected];
    else
        [userDefaults setInteger:[_profiles indexOfObject:self.selectedProfile] forKey:kProfileSelected];
    
    [userDefaults synchronize];
}

- (Profile *)selectedProfile {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger profileSelected = [userDefaults integerForKey:kProfileSelected];
    if (profileSelected == 0)
        return [Profile dictionaryToObject:[userDefaults objectForKey:kDefaultProfile]];
    else
        return [Profile dictionaryToObject:[userDefaults objectForKey:[NSString stringWithFormat:@"%i", profileSelected]]];
}

- (void)addProfile:(Profile *)profile {
    [self.profiles addObject:profile];
    [self savePreferences];
}

- (void)removeProfile:(Profile *)profile {
    [self.profiles removeObject:profile];
    [self savePreferences];
}

- (void)resetProfile {
    [self.selectedProfile resetProfile];
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
