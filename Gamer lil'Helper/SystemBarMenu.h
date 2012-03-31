//
//  SystemBarMenu.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 2/29/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PreferencesWindowController;

@interface SystemBarMenu : NSMenu <NSMenuDelegate>

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) PreferencesWindowController *preferencesWindowController;

@end
