//
//  TheSelectionizer.h
//  MyFirstOSXApp
//
//  Created by Logan Wright on 5/15/14.
//  Copyright (c) 2014 Logan Wright. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, MouseSelectionDirection) {
    MouseSelectionDirectionRight,
    MouseSelectionDirectionLeft
};

@interface TheSelectionizer : NSTextView

@property (nonatomic) MouseSelectionDirection mouseSelectionDirection;

@end
