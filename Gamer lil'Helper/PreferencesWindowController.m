//
//  PreferencesWindowController.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 3/21/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "PreferencesController.h"
#import "Profile.h"

@implementation PreferencesWindowController

@synthesize selectedProfile = _selectedProfile;

@synthesize preferencesWindow = _preferencesWindow;
@synthesize preferencesTabView = _preferencesTabView;
@synthesize generalTabViewItem = _generalTabViewItem;
@synthesize profilesTabViewItem = _profilesTabViewItem;

@synthesize applicationStartupCheckbox = _applicationStartupCheckbox;
@synthesize applicationUpdateCheckbox = _applicationUpdateCheckbox;
@synthesize desktopNotificationsCheckbox = _desktopNotificationsCheckbox;

@synthesize profilesPopup = _profilesPopup;
@synthesize addProfileButton = _addProfileButton;
@synthesize removeProfileButton = _removeProfileButton;
@synthesize mouseAccelerationSlider = _mouseAccelerationSlider;
@synthesize mouseSpeedSlider = _mouseSpeedSlider;
@synthesize keyboardKeyRepeatSlider = _keyboardKeyRepeatSlider;
@synthesize keyboardKeyDelaySlider = _keyboardKeyDelaySlider;
@synthesize keyboardFKeysCheckbox = _keyboardFKeysCheckbox;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        self.window.delegate = self;
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    //Fetch selected profile.
    
    self.applicationStartupCheckbox.state = [PreferencesController sharedInstance].shouldRunAtStart ? 1 : 0;
    self.applicationUpdateCheckbox.state = [PreferencesController sharedInstance].shouldCheckUpdates ? 1 : 0;
    self.desktopNotificationsCheckbox.state = [PreferencesController sharedInstance].shouldShowNotifications ? 1 : 0;
    
    self.mouseAccelerationSlider.integerValue = self.selectedProfile.mouseAcceleration.integerValue;
    self.mouseSpeedSlider.integerValue = self.selectedProfile.mouseSpeed.integerValue;
    self.keyboardKeyRepeatSlider.integerValue = self.selectedProfile.keyboardKeyRepeat.integerValue;
    self.keyboardKeyDelaySlider.integerValue = self.selectedProfile.keyboardKeyDelay.integerValue;
    
    self.keyboardFKeysCheckbox.state = self.selectedProfile.keyboardFKeys ? 1 : 0;
    
    [self.mouseAccelerationSlider setAltIncrementValue:1];
    [self.mouseSpeedSlider setAltIncrementValue:1];
    [self.keyboardKeyRepeatSlider setAltIncrementValue:1];
    [self.keyboardKeyDelaySlider setAltIncrementValue:1];
}

- (void)showWindow:(id)sender {
    [self.window center];
    [super showWindow:sender];
    [self.window makeKeyAndOrderFront:self];
    
    [NSApp activateIgnoringOtherApps:YES];
    
}

#pragma mark - NSWindowDelegate

- (BOOL)windowShouldClose:(id)sender {
    return YES;
}

- (void)windowWillClose:(NSNotification *)notification {
    //Save here?
}

#pragma mark - IBActions

- (IBAction)applicationStartupCheckboxAction:(id)sender {
    [PreferencesController sharedInstance].shouldRunAtStart = [(NSButton *)sender state] ? YES : NO;
}

- (IBAction)applicationUpdateCheckboxAction:(id)sender {
    [PreferencesController sharedInstance].shouldCheckUpdates = [(NSButton *)sender state] ? YES : NO;
}

- (IBAction)desktopNotificationsCheckboxAction:(id)sender {
    [PreferencesController sharedInstance].shouldShowNotifications = [(NSButton *)sender state] ? YES : NO;
}

- (IBAction)popupProfileChanged:(id)sender {
    //Fetch profile
    //Change profile
    //Change values
}

- (IBAction)addProfile:(id)sender {
    Profile *newProfile = [[Profile alloc] initWithName:@"teste"];
    [[PreferencesController sharedInstance] addProfile:newProfile];
}

- (IBAction)removeProfile:(id)sender {
    [[PreferencesController sharedInstance] removeProfile:self.selectedProfile];
}

- (IBAction)resetProfile:(id)sender {
    [[PreferencesController sharedInstance] resetProfile];
}

- (IBAction)mouseAccelerationSliderAction:(id)sender {
    self.selectedProfile.mouseAcceleration = [NSNumber numberWithInteger:[sender integerValue]];
}

- (IBAction)mouseSpeedSliderAction:(id)sender {
    self.selectedProfile.mouseSpeed = [NSNumber numberWithInteger:[sender integerValue]];
}

- (IBAction)keyboardKeyRepeatSliderAction:(id)sender {
    self.selectedProfile.keyboardKeyRepeat = [NSNumber numberWithInteger:[sender integerValue]];
}

- (IBAction)keyboardKeyDelaySliderAction:(id)sender {
    self.selectedProfile.keyboardKeyDelay = [NSNumber numberWithInteger:[sender integerValue]];
}

- (IBAction)keyboardFKeysCheckboxAction:(id)sender {
    self.selectedProfile.keyboardFKeys = [(NSButton *)sender state] ? YES : NO;
}


@end
