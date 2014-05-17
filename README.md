TheSelectionizer
================

An answer to a stack overflow question poised here: http://stackoverflow.com/questions/20116963/how-can-i-get-the-selection-direction-of-an-nstextview/23667851#23667851


#SET UP

### Subclass NSTextView

In Subclass.h

```ObjC
#import <Cocoa/Cocoa.h>

@interface TheSelectionizer : NSTextView

@property (nonatomic) NSRange lastAnchorPoint;

@end

```

In Subclass.m

```ObjC
#import "TheSelectionizer.h"

- (void)setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)stillSelectingFlag {

    if (charRange.length == 0) {
        _lastAnchorPoint = charRange;
    }
    [super setSelectedRange:charRange affinity:affinity stillSelecting:stillSelectingFlag];
}

@end
```

### Set up delegate

Make sure you have set up your delegate to conform to `NSTextViewDelegateProtocol` and assign it as the delegate of your textView

```ObjC
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
```
