//
//  NSUserDefaults+Property.m
//
//  Created by Naoki Hiroshima on 3/20/13.
//  Copyright (c) 2013 Naoki Hiroshima. All rights reserved.
//

#import "NSUserDefaults+Property.h"
#import <objc/runtime.h>

@implementation NSUserDefaults (Property)

#pragma mark - NSObject

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    BOOL setter = NO;
    NSString* key = [NSStringFromSelector(selector) lowercaseString];
    if ([key rangeOfString:@"set"].location == 0) {
        key = [key substringWithRange:NSMakeRange(3, [key length]-4)];
        setter = YES;
    }

    char signature[] = "v@:@";
    
    unichar type = [[self propertyAttributesWithName:key] characterAtIndex:1];
    if (type) {
        if (setter) {
            signature[3] = type;  // "v@:B" for -(void)setFoo:(BOOL)
        } else {
            signature[0] = type;
            signature[3] = '\0';  // "B@:" for -(BOOL)foo
        }
    }
    return [NSMethodSignature signatureWithObjCTypes:signature];
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
    BOOL setter = NO;
    NSString* key = [NSStringFromSelector([invocation selector]) lowercaseString];
    if ([key rangeOfString:@"set"].location == 0) {
        key = [key substringWithRange:NSMakeRange(3, [key length]-4)];
        setter = YES;
    }
    
    NSString* attr = [self propertyAttributesWithName:key];
    //NSLog(@"key(%@) attr(%@)", key, attr);
    switch ([attr characterAtIndex:1]) {
        case 'c':  // char
        case 'B': {  // BOOL
            BOOL value;
            if (setter) {
                [invocation getArgument:&value atIndex:2];
                [self setBool:value forKey:key];
            } else {
                value = [self boolForKey:key];
                [invocation setReturnValue:&value];
            }
            break;
        }
        case 'f': {  // float
            float value;
            if (setter) {
                [invocation getArgument:&value atIndex:2];
                [self setFloat:value forKey:key];
            } else {
                value = [self floatForKey:key];
                [invocation setReturnValue:&value];
            }
            break;
        }
        case 'd': {  // double
            double value;
            if (setter) {
                [invocation getArgument:&value atIndex:2];
                [self setDouble:value forKey:key];
            } else {
                value = [self doubleForKey:key];
                [invocation setReturnValue:&value];
                
            }
            break;
        }
        case 'i': {  // int
            int value;
            if (setter) {
                [invocation getArgument:&value atIndex:2];
                [self setInteger:value forKey:key];
            } else {
                value = (int)[self integerForKey:key];
                [invocation setReturnValue:&value];
                
            }
            break;
        }
        case 'q': {  // long long
            long long value;
            if (setter) {
                [invocation getArgument:&value atIndex:2];
                [self setInteger:(NSInteger)value forKey:key];
            } else {
                value = [self integerForKey:key];
                [invocation setReturnValue:&value];
            }
            break;
        }
        case '@': {  // NSObject
            __unsafe_unretained id obj;
            BOOL isNSURL = [attr rangeOfString:@"NSURL"].location != NSNotFound;
            if (setter) {
                [invocation getArgument:&obj atIndex:2];
                if (isNSURL) {
                    [self setURL:obj forKey:key];
                } else {
                    [self setObject:obj forKey:key];
                }
            } else {
                if (isNSURL) {
                    obj = [self URLForKey:key];
                } else {
                    obj = [self objectForKey:key];
                }
                [invocation setReturnValue:&obj];
            }
            break;
        }
        default:
            NSAssert(NO, @"Unknown data type: %@ / %@", NSStringFromSelector([invocation selector]), attr);
            break;
    }
}

#pragma mark - Private methods

- (NSString*)propertyAttributesWithName:(NSString*)name
{
    NSString* propertyAttributes = nil;
    
    unsigned int outCount;
    objc_property_t* properties = class_copyPropertyList([self class], &outCount);
    
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* s = property_getName(property);
        if ([[[NSString stringWithUTF8String:s] lowercaseString] isEqualToString:name]) {
            const char* attributes = property_getAttributes(property);
            propertyAttributes = [NSString stringWithUTF8String:attributes];
            break;
        }
    }
    free(properties);
    
    return propertyAttributes;
}

#pragma mark - Class methods

+ (NSUserDefaults*)defaults
{
    return [self standardUserDefaults];
}

@end
