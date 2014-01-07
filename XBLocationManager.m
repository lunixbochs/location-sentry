#import "XBLocationManager.h"
#import "SBAppSwitcherModel.h"

#include <dlfcn.h>

typedef NSDictionary *(* NSDIiiPTR)(int, int);
static NSDIiiPTR CLCopyAppsUsingLocation;

@implementation XBLocationManager

@synthesize appList;
@synthesize locationApps;

#pragma mark Singleton Methods

+(id)sharedManager {
    static XBLocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    [sharedManager updateLocationApps];
    [sharedManager updateAppList];
    return sharedManager;
}

-(id)init {
    if (self = [super init]) {
        CLCopyAppsUsingLocation = (NSDIiiPTR)dlsym(RTLD_DEFAULT, "CLCopyAppsUsingLocation");
    }
    return self;
}

-(void)updateLocationApps {
    if (self.locationApps) {
        [self.locationApps release];
    }
    self.locationApps = CLCopyAppsUsingLocation(0, 0);
}

-(void)updateAppList {
    Class SBAppSwitcherModel = NSClassFromString(@"SBAppSwitcherModel");
    self.appList = [[SBAppSwitcherModel sharedInstance] identifiers];
}

-(NSString *)iconForIndex:(NSUInteger)index {
    NSString *bundle = [self.appList objectAtIndex:index];
    if (bundle) {
        NSDictionary *app = [self.locationApps objectForKey:bundle];
        NSUInteger started = [[app objectForKey:@"LocationTimeStarted"] intValue];
        NSUInteger stopped = [[app objectForKey:@"LocationTimeStopped"] intValue];

        NSLog(@"%@ Background: %d Time: %d", bundle, started, [[app objectForKey:@"LocationTimeStarted"] intValue]);
        NSLog(@"%@ BackgroundStopped: %d Time Stopped: %d", bundle, stopped, [[app objectForKey:@"LocationTimeStopped"] intValue]);
        if (started != 0) {
            return @"/Applications/Preferences.app/LocationActive.png";
        } else if (stopped != 0) {
            return @"/Applications/Preferences.app/LocationRecent.png";
        }
    }
    return nil;
}

@end
