//
//  Util.h
//  SHOCO2
//
//  Created by Henry Nguyen Quang on 8/16/20.
//  Copyright © 2020 Henry Nguyen Quang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//@import CoreGraphics;

@interface Util : NSObject

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (NSString *) randomStringWithLength: (NSInteger) len;
+ (BOOL)validateEmail:(NSString *)email;
+ (NSString * )setCurrentDateWithFormat:(NSString *)_dateFormatter;
+ (NSString *)setDateWithString:(NSString *)_dateString;
+ (NSString*) applicationDocumentsDirectory;
@end

