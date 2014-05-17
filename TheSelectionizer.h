//
//  TheSelectionizer.h
//  MyFirstOSXApp
//
//  Created by Logan Wright on 5/15/14.
//  Copyright (c) 2014 Logan Wright. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TheSelectionizer : NSTextView

@property (nonatomic) NSRange lastAnchorPoint;

@end


// If you select by mouse, the first direction arrowed sets the opposite end as the anchor