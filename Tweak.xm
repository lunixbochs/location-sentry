#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>

#import "SBAppSliderItemScrollView.h"
#import "XBLocationManager.h"

%hook SBAppSliderItemScrollView

-(void)didMoveToSuperview {
    %orig;
    NSUInteger index = [[self superview].subviews indexOfObject:self];
    if (index == NSNotFound || index == 0) {
        return;
    }
    NSString *icon = [[XBLocationManager sharedManager] iconForIndex:index - 1];
    if (icon != nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];

        CGRect frame = imageView.frame;
        /* top */
        // frame.origin.y = -8;
        /* bottom */
        frame.origin.y = 280 - 24;
        /* right */
        frame.origin.x = self.frame.size.width - 24;
        /* left */
        // frame.origin.x = -8;
        /* x center */
        // frame.origin.x = self.frame.size.width / 2 - frame.size.width / 2;

        imageView.frame = frame;

        [self addSubview:imageView];
        [imageView release];
    }
}

-(void)didAddSubview:(UIView *)subview {
    %orig;
    if ([NSStringFromClass([subview class]) isEqualToString:@"SBAppSwitcherPageView"]) {
        [self sendSubviewToBack:subview];
    }
}

%end
