# NSUserDefaults+Property

[![Version](http://cocoapod-badges.herokuapp.com/v/NSUserDefaults+Property/badge.png)](http://cocoadocs.org/docsets/NSUserDefaults+Property)
[![Platform](http://cocoapod-badges.herokuapp.com/p/NSUserDefaults+Property/badge.png)](http://cocoadocs.org/docsets/NSUserDefaults+Property)


## Usage

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

To run the example project; clone the repo, and run `pod install` from the Example directory first.

## Installation

NSUserDefaults+Property is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "NSUserDefaults+Property"

## Author

Naoki Hiroshima, n@h7a.org

## License

NSUserDefaults+Property is available under the WTFPL. See the LICENSE file for more info.
