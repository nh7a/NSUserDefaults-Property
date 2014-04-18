//
//  NSUserDefaults+Example.h
//  Example
//
//  Created by Naoki Hiroshima on 4/8/14.
//
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+Property.h"

@interface NSUserDefaults (Example)

@property BOOL my_BOOL;
@property float my_float;
@property double my_double;
@property NSInteger my_NSInteger;
@property NSNumber* my_NSNumber;

@property NSString* my_NSString;
@property NSArray* my_NSArray;
@property NSDictionary* my_NSDictionary;

@property NSData* my_NSData;
@property NSDate* my_NSDate;
@property NSURL* my_NSURL;

@end
