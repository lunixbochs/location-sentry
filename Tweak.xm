#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>

#import "SBAppSliderItemScrollView.h"
#import "XBLocationManager.h"

%hook SBAppSliderItemScrollView

void addCard(id self, UIView *subview) {
    NSUInteger index = [[self superview].subviews indexOfObject:self];
    if (index == NSNotFound || index == 0) {
        return;
    }
    NSString *icon = [[XBLocationManager sharedManager] iconForIndex:index - 1];
    if (icon != nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];

        CGRect frame = imageView.frame;
        CGRect subframe = subview.frame;
        frame.origin.x = subframe.origin.x;
        frame.origin.y = subframe.origin.y;

        frame.origin.x += subframe.size.width;
        frame.origin.y += subframe.size.height;

        frame.origin.x -= frame.size.width + 4;
        frame.origin.y -= frame.size.height + 5;

#if 0
        /* top */
        // frame.origin.y = -8;
        /* bottom */
        frame.origin.y = 280 - 30;
        /* right */
        frame.origin.x = self.frame.size.width - 30;
        /* left */
        // frame.origin.x = -8;
        /* x center */
        // frame.origin.x = self.frame.size.width / 2 - frame.size.width / 2;
#endif

        imageView.frame = frame;

        [self addSubview:imageView];
        [self bringSubviewToFront:imageView];
        [imageView release];
    }
}

-(void)didAddSubview:(UIView *)subview {
    %orig;
    if ([NSStringFromClass([subview class]) isEqualToString:@"SBAppSwitcherPageView"]) {
        addCard(self, subview);
    }
}

%end
