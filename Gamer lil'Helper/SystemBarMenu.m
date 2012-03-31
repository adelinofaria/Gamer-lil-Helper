//
//  SystemBarMenu.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 2/29/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "SystemBarMenu.h"
#import "PreferencesWindowController.h"

@implementation SystemBarMenu

@synthesize statusItem = _statusItem;
@synthesize preferencesWindowController = _preferencesWindowController;

- (void)awakeFromNib {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.image = [NSImage imageNamed:@"icon_black"];
    _statusItem.highlightMode = YES;
    _statusItem.menu = self;
    self.delegate = self;
}

#pragma mark - Menu Events

- (void)menuNeedsUpdate:(NSMenu *)menu {
    
}

- (void)menuWillOpen:(NSMenu *)menu {
    _statusItem.image = [NSImage imageNamed:@"icon_white"];
}

- (void)menuDidClose:(NSMenu *)menu {
    _statusItem.image = [NSImage imageNamed:@"icon_black"];
}

#pragma mark - Menu Actions

- (IBAction)openAbout:(id)sender {
    [[NSApplication sharedApplication] orderFrontStandardAboutPanel:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)openUpdate:(id)sender {
    
}

- (IBAction)openPreferences:(id)sender {
    self.preferencesWindowController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindow"];
    self.preferencesWindowController.window.delegate = self.preferencesWindowController;
    [self.preferencesWindowController showWindow:self];
}

- (IBAction)profileQuickSelection:(id)sender {
    
}

- (IBAction)quit:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

/*- (void)updateMenu {
    DLog(@"Updating status...");
    
    // TODO - fix this, not working
    // prevent GPU from switching back after apps quit
    //    if (!integrated && ![state usingLegacy] && [integratedOnly state] > 0 && canPreventSwitch) {
    //        DLog(@"Preventing switch to Discrete GPU. Setting canPreventSwitch to NO so that this doesn't get stuck in a loop, changing in 5 seconds...");
    //        canPreventSwitch = NO;
    //        [self setMode:integratedOnly];
    //        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(shouldPreventSwitch) userInfo:nil repeats:NO];
    //        return;
    //    }
    
    // get updated GPU string
    NSString *cardString = [state usingIntegrated] ? [state integratedString] : [state discreteString];
    
    // set menu bar icon
    if ([prefs shouldUseImageIcons]) {
        [statusItem setImage:[NSImage imageNamed:[state usingIntegrated] ? @"integrated.png" : @"discrete.png"]];
    } else {
        // grab first character of GPU string for the menu bar icon
        unichar firstLetter;
        
        if ([state usingLegacy] || ![prefs shouldUseSmartMenuBarIcons]) {
            firstLetter = [state usingIntegrated] ? 'i' : 'd';
        } else {
            firstLetter = [cardString characterAtIndex:0];
        }
        
        // format firstLetter into an NSString *
        NSString *letter = [[NSString stringWithFormat:@"%C", firstLetter] lowercaseString];
        int fontSize = ([letter isEqualToString:@"n"] || [letter isEqualToString:@"a"] ? 19 : 18);
        
        // set the correct font
        NSFontManager *fontManager = [NSFontManager sharedFontManager];
        NSFont *boldItalic = [fontManager fontWithFamily:@"Georgia"
                                                  traits:NSBoldFontMask|NSItalicFontMask
                                                  weight:0
                                                    size:fontSize];
        
        // create NSAttributedString with font
        NSDictionary *attributes = [[[NSDictionary alloc] initWithObjectsAndKeys:
                                     boldItalic, NSFontAttributeName, 
                                     [NSNumber numberWithDouble:2.0], NSBaselineOffsetAttributeName, nil] autorelease];
        NSAttributedString *title = [[[NSAttributedString alloc] 
                                      initWithString:letter
                                      attributes: attributes] autorelease];
        
        // set menu bar text "icon"
        [statusItem setAttributedTitle:title];
    }    
    
    [currentCard setTitle:[Str(@"Card") stringByReplacingOccurrencesOfString:@"%%" withString:cardString]];
    
    if ([state usingIntegrated]) DLog(@"%@ in use. Sweet deal! More battery life.", [state integratedString]);
    else DLog(@"%@ in use. Bummer! Less battery life for you.", [state discreteString]);
    
    if (![state usingIntegrated]) [self updateProcessList];
}

- (void)updateProcessList {
    for (NSMenuItem *mi in [statusMenu itemArray]) {
        if ([mi indentationLevel] > 0 && ![mi isEqual:processList]) [statusMenu removeItem:mi];
    }
    
    // if we're on Integrated (or using a 9400M/9600M GT model), no need to display/update the list
    BOOL procList = ![state usingIntegrated] && ![state usingLegacy];
    [processList setHidden:!procList];
    [processesSeparator setHidden:!procList];
    [dependentProcesses setHidden:!procList];
    if (!procList) return;
    
    DLog(@"Updating process list...");
    
    NSArray *processes = [SystemInfo getTaskList];
    
    [processList setHidden:([processes count] > 0)];
    
    for (NSDictionary *dict in processes) {
        NSString *taskName = [dict objectForKey:kTaskItemName];
        NSString *pid = [dict objectForKey:kTaskItemPID];
        NSString *title = [NSString stringWithString:taskName];
        if (![pid isEqualToString:@""]) title = [title stringByAppendingFormat:@", PID: %@", pid];
        
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:title action:nil keyEquivalent:@""];
        [item setIndentationLevel:1];
        [statusMenu insertItem:item atIndex:([statusMenu indexOfItem:processList] + 1)];
        [item release];
    }
}*/

@end
