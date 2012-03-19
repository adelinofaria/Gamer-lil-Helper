//
//  AppDelegate.h
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 2/28/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SystemBarMenu;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, retain) IBOutlet SystemBarMenu *statusMenu;

@end
