//
//  TheSelectionizer.m
//  MyFirstOSXApp
//
//  Created by Logan Wright on 5/15/14.
//  Copyright (c) 2014 Logan Wright. All rights reserved.
//

#import "TheSelectionizer.h"

@interface TheSelectionizer ()

@property (nonatomic) NSRange lastRange;

@end

@implementation TheSelectionizer

- (void)setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)stillSelectingFlag {
    
    if (charRange.length == 0) {
        _lastRange = charRange;
    }
    else {
        if (charRange.location < _lastRange.location) {
            // NSLog(@"Selecting LEFT");
            _mouseSelectionDirection = MouseSelectionDirectionLeft;
        }
        else {
            // NSLog(@"Selecting RIGHT");
            _mouseSelectionDirection = MouseSelectionDirectionRight;
        }
    }
    
    [super setSelectedRange:charRange affinity:affinity stillSelecting:stillSelectingFlag];
}

@end
