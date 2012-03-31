//
//  AppDelegate.m
//  Gamer lil'Helper
//
//  Created by Adelino Faria on 2/28/12.
//  Copyright (c) 2012 Rabid Cat. All rights reserved.
//

#import "AppDelegate.h"
#import "MouseSettings.h"
#import "KeyboardSettings.h"

@implementation AppDelegate

@synthesize statusMenu = _statusMenu;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    /*
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"LaunchAsAgentApp"]) 
    {
        ProcessSerialNumber psn = { 0, kCurrentProcess };
        TransformProcessType(&psn, kProcessTransformToForegroundApplication);
        SetFrontProcess(&psn);
    }
     */
    
    //NSLog(@"MouseAcceleration = %f", [MouseSettings getMouseAcceleration]);
    //NSLog(@"MouseSpeed = %f", [MouseSettings getMouseSpeed]);
    
    /*
    NSLog(@"%i",[KeyboardSettings getFnKeyMode]);
    
    if ([KeyboardSettings getFnKeyMode] == 0) {
        if ([KeyboardSettings setFnKeyMode:1])
            NSLog(@"Success!");
        else
            NSLog(@"Negative");
    }
    else {
        if ([KeyboardSettings setFnKeyMode:0])
            NSLog(@"Success!");
        else
            NSLog(@"Negative");
    }
    
    NSLog(@"%i",[KeyboardSettings getFnKeyMode]);*/
}

@end
