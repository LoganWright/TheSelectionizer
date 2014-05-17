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
    
    if (newSelectedCharRange.length != 0) {
        
        TheSelectionizer * selectionizer = (TheSelectionizer *)textView;

        int anchorStart = (int)selectionizer.lastAnchorPoint.location;
        int selectionStart = (int)newSelectedCharRange.location;
        int selectionLength = (int)newSelectedCharRange.length;
        
        /*
         If mouse selects left, and then a user arrows right, or the opposite, anchor point flips.
         */
        int difference = anchorStart - selectionStart;
        if (difference > 0 && difference != selectionLength) {
            if (oldSelectedCharRange.location == newSelectedCharRange.location) {
                // We were selecting left via mouse, but now we are selecting to the right via arrows
                anchorStart = selectionStart;
            }
            else {
                // We were selecting right via mouse, but now we are selecting to the left via arrows
                anchorStart = selectionStart + selectionLength;
            }
            selectionizer.lastAnchorPoint = NSMakeRange(anchorStart, 0);
        }
        
        // Evaluate Selection Direction
        if (anchorStart == selectionStart) {
            if (oldSelectedCharRange.length < newSelectedCharRange.length) {
                // Bigger
                NSLog(@"Will select right in overall right selection");
            }
            else {
                // Smaller
                NSLog(@"Will select left in overall right selection");
            }
        }
        else {
            if (oldSelectedCharRange.length < newSelectedCharRange.length) {
                // Bigger
                NSLog(@"Will select left in overall left selection");
            }
            else {
                // Smaller
                NSLog(@"Will select right in overall left selection");
            }
        }
    }
    
    return newSelectedCharRange;
}

@end
