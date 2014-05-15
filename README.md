TheSelectionizer
================

An answer to a stack overflow question poised here: http://stackoverflow.com/questions/20116963/how-can-i-get-the-selection-direction-of-an-nstextview/23667851#23667851


#SET UP

### Subclass NSTextView

In Subclass.h

```ObjC
#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, MouseSelectionDirection) {
    MouseSelectionDirectionRight,
    MouseSelectionDirectionLeft
};

@interface TheSelectionizer : NSTextView

@property (nonatomic) MouseSelectionDirection mouseSelectionDirection;

@end

```

In Subclass.m

```ObjC
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
```

### Set up delegate

Make sure you have set up your delegate to conform to `NSTextViewDelegateProtocol` and assign it as the delegate of your textView

```ObjC
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
```
