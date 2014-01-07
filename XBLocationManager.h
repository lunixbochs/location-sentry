#import <Foundation/Foundation.h>

@interface XBLocationManager : NSObject {
    NSArray *appList;
    NSDictionary *locationApps;
}

@property (nonatomic, retain) NSArray *appList;
@property (nonatomic, retain) NSDictionary *locationApps;

+(void)load;
+(id)sharedManager;
-(void)updateLocationApps;
-(void)updateAppList;
-(NSString *)iconForIndex:(NSUInteger)index;

@end
