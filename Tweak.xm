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
        frame.origin.x = self.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = -frame.size.height * 1.5;
        imageView.frame = frame;

        [self addSubview:imageView];
        [imageView release];
    }
}

%end
