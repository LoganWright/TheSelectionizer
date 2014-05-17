//
//  TheSelectionizer.m
//  MyFirstOSXApp
//
//  Created by Logan Wright on 5/15/14.
//  Copyright (c) 2014 Logan Wright. All rights reserved.
//

#import "TheSelectionizer.h"

@implementation TheSelectionizer

- (void)setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)stillSelectingFlag {
    
    if (charRange.length == 0) {
        _lastAnchorPoint = charRange;
    }
    [super setSelectedRange:charRange affinity:affinity stillSelecting:stillSelectingFlag];
}

@end
