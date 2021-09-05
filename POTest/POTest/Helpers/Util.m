//
//  Util.m
//  SHOCO2
//
//  Created by Henry Nguyen Quang on 8/16/20.
//  Copyright © 2020 Henry Nguyen Quang. All rights reserved.
//

#import "Util.h"
#include <stdlib.h>
#import "Constants.h"

@implementation Util{
    
    
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3){
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@", [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6){
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    unsigned int baseValue; [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue]; float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}
+ (NSString *) randomStringWithLength: (NSInteger) len {
    
    // NSString *UUID = [[NSUUID UUID] UUIDString];
    // NSString *string = []
    NSString *letters = @"abcdefghijk124455667788lmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i=0; i<len; i++) {
        // NSInteger r = (NSInteger)arc4random_uniform((NSInteger)letters.length);
        [randomString appendFormat: @"%C",[letters characterAtIndex: arc4random() % [letters length]] ];
    }
    
    return randomString;
}
+ (BOOL)validateEmail:(NSString *)email
{
    email = [email lowercaseString];
    NSString *emailRegex = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


+ (NSString*) applicationDocumentsDirectory{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    return docsDir;
}

+ (NSString * )setCurrentDateWithFormat:(NSString *)_dateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:_dateFormatter];
    NSString *stringFromDate = [dateFormatter stringFromDate:[NSDate date]];
    return stringFromDate;
}

+ (NSString *)setDateWithString:(NSString *)_dateString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];

    NSDate *dateFromString = [dateFormatter dateFromString:_dateString];//[[NSDate alloc] init];

    dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDate = [dateFormatter stringFromDate:dateFromString];
    
    return newDate;
    
}


@end
