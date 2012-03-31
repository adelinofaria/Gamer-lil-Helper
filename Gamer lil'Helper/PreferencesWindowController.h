//
//  PreferencesWindowController.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/21/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Profile;

@interface PreferencesWindowController : NSWindowController <NSWindowDelegate>

@property (nonatomic, retain)Profile *selectedProfile;

@property (nonatomic, retain)IBOutlet NSWindow *preferencesWindow;
@property (nonatomic, retain)IBOutlet NSTabView *preferencesTabView;
@property (nonatomic, retain)IBOutlet NSTabViewItem *generalTabViewItem;
@property (nonatomic, retain)IBOutlet NSTabViewItem *profilesTabViewItem;

@property (nonatomic, retain)IBOutlet NSButton *applicationStartupCheckbox;
@property (nonatomic, retain)IBOutlet NSButton *applicationUpdateCheckbox;
@property (nonatomic, retain)IBOutlet NSButton *desktopNotificationsCheckbox;

@property (nonatomic, retain)IBOutlet NSButton *profilesPopup;
@property (nonatomic, retain)IBOutlet NSButton *addProfileButton;
@property (nonatomic, retain)IBOutlet NSButton *removeProfileButton;
@property (nonatomic, retain)IBOutlet NSSlider *mouseAccelerationSlider;
@property (nonatomic, retain)IBOutlet NSSlider *mouseSpeedSlider;
@property (nonatomic, retain)IBOutlet NSSlider *keyboardKeyRepeatSlider;
@property (nonatomic, retain)IBOutlet NSSlider *keyboardKeyDelaySlider;
@property (nonatomic, retain)IBOutlet NSButton *keyboardFKeysCheckbox;

@end
