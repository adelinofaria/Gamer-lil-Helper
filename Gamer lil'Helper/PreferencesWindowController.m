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

@interface PreferencesWindowController (Private)

- (void)updateProfilesPopup;

@end

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

@synthesize profileNameWindow = _profileNameWindow;
@synthesize profileNameOkButton = _profileNameOkButton;
@synthesize profileNameCancelButton = _profileNameCancelButton;
@synthesize profileNameTextField = _profileNameTextField;

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
    
    self.profileNameTextField.delegate = self;
    
    self.applicationStartupCheckbox.state = [PreferencesController sharedInstance].shouldRunAtStart ? 1 : 0;
    self.applicationUpdateCheckbox.state = [PreferencesController sharedInstance].shouldCheckUpdates ? 1 : 0;
    self.desktopNotificationsCheckbox.state = [PreferencesController sharedInstance].shouldShowNotifications ? 1 : 0;
    
    [self updateProfilesPopup];
    
    [self.mouseAccelerationSlider setFloatValue:self.selectedProfile.mouseAcceleration.floatValue];
    [self.mouseSpeedSlider setFloatValue:self.selectedProfile.mouseSpeed.floatValue];
    [self.keyboardKeyRepeatSlider setFloatValue:self.selectedProfile.keyboardKeyRepeat.floatValue];
    [self.keyboardKeyDelaySlider setFloatValue:self.selectedProfile.keyboardKeyDelay.floatValue];
    
    self.keyboardFKeysCheckbox.state = self.selectedProfile.keyboardFKeys ? 1 : 0;
    
    [self.mouseAccelerationSlider setAltIncrementValue:1];
    [self.mouseSpeedSlider setAltIncrementValue:1];
    [self.keyboardKeyRepeatSlider setAltIncrementValue:1];
    [self.keyboardKeyDelaySlider setAltIncrementValue:1];
}

- (void)showWindow:(id)sender {
    [super showWindow:sender];
    [self.window makeKeyAndOrderFront:self];
    
    [NSApp activateIgnoringOtherApps:YES];
}

- (void)updateProfilesPopup {
    self.selectedProfile = [[PreferencesController sharedInstance] selectedProfile];
    
    for (int i = 0; i < [[PreferencesController sharedInstance].profiles count]; i++)
        [self.profilesPopup addItemWithTitle:((Profile *)[[PreferencesController sharedInstance].profiles objectAtIndex:i]).name];
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
    [[PreferencesController sharedInstance] savePreferences];
}

#pragma mark NSTextFieldDelegate

- (void)controlTextDidChange:(NSNotification *)obj {
    if([obj object] == self.profileNameTextField)
    {
        if (![self.profileNameTextField.stringValue isEqualToString:@""])
            [self.profileNameOkButton setEnabled:YES];
        else
            [self.profileNameOkButton setEnabled:NO];
    }
}

#pragma mark - Sheet Delegate

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    [sheet orderOut:self];
    
    [self.profileNameOkButton setEnabled:NO];
    [self.profileNameTextField setStringValue:@""];
}

#pragma mark - IBActions

- (IBAction)applicationStartupCheckboxAction:(id)sender {
    [PreferencesController sharedInstance].shouldRunAtStart = [(NSButton *)sender state] ? YES : NO;
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)applicationUpdateCheckboxAction:(id)sender {
    [PreferencesController sharedInstance].shouldCheckUpdates = [(NSButton *)sender state] ? YES : NO;
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)desktopNotificationsCheckboxAction:(id)sender {
    [PreferencesController sharedInstance].shouldShowNotifications = [(NSButton *)sender state] ? YES : NO;
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)popupProfileChanged:(id)sender {
    //Fetch profile
    //Change profile
    //Change values
}

- (IBAction)addProfile:(id)sender {
    [NSApp beginSheet:self.profileNameWindow modalForWindow:self.window modalDelegate:self didEndSelector:@selector(didEndSheet:returnCode:contextInfo:) contextInfo:nil];
}

- (IBAction)removeProfile:(id)sender {
    [[PreferencesController sharedInstance] removeProfile:self.selectedProfile];
    
    [self updateProfilesPopup];
}

- (IBAction)resetProfile:(id)sender {
    [[PreferencesController sharedInstance] resetProfile];
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)mouseAccelerationSliderAction:(id)sender {
    self.selectedProfile.mouseAcceleration = [NSNumber numberWithInteger:[sender integerValue]];
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)mouseSpeedSliderAction:(id)sender {
    self.selectedProfile.mouseSpeed = [NSNumber numberWithInteger:[sender integerValue]];
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)keyboardKeyRepeatSliderAction:(id)sender {
    self.selectedProfile.keyboardKeyRepeat = [NSNumber numberWithInteger:[sender integerValue]];
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)keyboardKeyDelaySliderAction:(id)sender {
    self.selectedProfile.keyboardKeyDelay = [NSNumber numberWithInteger:[sender integerValue]];
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)keyboardFKeysCheckboxAction:(id)sender {
    self.selectedProfile.keyboardFKeys = [(NSButton *)sender state] ? YES : NO;
    [[PreferencesController sharedInstance] savePreferences];
}

- (IBAction)profileNameSave:(id)sender {
    Profile *newProfile = [[Profile alloc] initWithName:self.profileNameTextField.stringValue];
    
    [NSApp endSheet:self.profileNameWindow];
    
    [[PreferencesController sharedInstance] addProfile:newProfile];
    
    [self updateProfilesPopup];
}

- (IBAction)profileNameCancel:(id)sender {
    [NSApp endSheet:self.profileNameWindow];
}

@end
