//
//  AppDelegate.m
//  Example
//
//  Created by Naoki Hiroshima on 4/8/14.
//
//

#import "AppDelegate.h"

#import "NSUserDefaults+Example.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults* d = [NSUserDefaults standardUserDefaults];
    
    d.my_BOOL = YES;
    d.my_float = FLT_MAX;
    d.my_double = DBL_MAX;
    d.my_NSInteger = INT_MAX;
    d.my_NSNumber = @123456789.012345;
    
    d.my_NSString = @"no string attached";
    d.my_NSArray = @[@1, @2, @3];
    d.my_NSDictionary = @{@"key here" : @"value here"};

    d.my_NSDate = [NSDate date];;
    d.my_NSData = [NSData dataWithBytes:"\0\1\2\3" length:4];
    d.my_NSURL = [NSURL URLWithString:@"http://example.com"];
    
    NSLog(@"BOOL: %d", d.my_BOOL);
    NSLog(@"float: %f", d.my_float);
    NSLog(@"double: %f", d.my_double);
    NSLog(@"NSInteger: %i", d.my_NSInteger);
    NSLog(@"NSNumber: %@", d.my_NSNumber);
    
    NSLog(@"NSString: %@", d.my_NSString);
    NSLog(@"NSArray: %@", d.my_NSArray);
    NSLog(@"NSDictionary: %@", d.my_NSDictionary);
    
    NSLog(@"NSDate: %@", d.my_NSDate);
    NSLog(@"NSData: %@", d.my_NSData);
    NSLog(@"NSURL: %@", d.my_NSURL);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
