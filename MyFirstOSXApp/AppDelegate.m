//
//  AppDelegate.m
//  MyFirstOSXApp
//
//  Created by Logan Wright on 5/15/14.
//  Copyright (c) 2014 Logan Wright. All rights reserved.
//

#import "AppDelegate.h"

#import "TheSelectionizer.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    TheSelectionizer *selectionizer = [[TheSelectionizer alloc] initWithFrame:NSRectFromCGRect(CGRectMake(20, 20, 500, 500))];
    selectionizer.delegate = self;
    
    NSWindow * aWindow = self.window;
    [aWindow setContentView:selectionizer];
    [aWindow makeKeyAndOrderFront:nil];
    [aWindow makeFirstResponder:selectionizer];
}

#pragma mark TEXT VIEW DELEGATE

- (NSRange) textView:(NSTextView *)textView willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange {
    
    // If our new range is 0, we're not selecting anything
    if (newSelectedCharRange.length != 0) {
        
        int difference = (int)(newSelectedCharRange.length - oldSelectedCharRange.length);
        if (difference < 0) difference *= -1;
        if (difference == 1) {
            // 1 means that a Keyboard arrow triggered the selection
            if (oldSelectedCharRange.location == newSelectedCharRange.location) {
                NSLog(@"Right Selection");
                if (oldSelectedCharRange.length < newSelectedCharRange.length) {
                    NSLog(@"Will arrow right in overall right selection");
                }
                else {
                    NSLog(@"Will arrow left in overall right selection");
                }
            }
            else {
                NSLog(@"Left Selection");
                if (oldSelectedCharRange.length < newSelectedCharRange.length) {
                    NSLog(@"Will arrow left in overall left selection");
                }
                else {
                    NSLog(@"Will arrow right in overall left selection");
                }
            }
        }
        else {
            // Selection was triggered by mouse
            // ...
            NSLog(@"Mouse done selecting");
            TheSelectionizer * selectionizer = (TheSelectionizer *)textView;
            if (selectionizer.mouseSelectionDirection == MouseSelectionDirectionLeft) {
                NSLog(@"Mouse finished selecting left");
            }
            else if (selectionizer.mouseSelectionDirection == MouseSelectionDirectionRight) {
                NSLog(@"Mouse finished selecting right");
            }
        }
    }
    
    return newSelectedCharRange;
}

@end
