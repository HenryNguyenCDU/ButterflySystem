//
//  Demo Butterfly
//
//  Created by Henry Nguyen on 6/4/15.
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSAppHelper : NSObject

+ (BOOL)copyFileFromCurrentPath:(NSString *)_currentPath toDestionation:(NSString *)_destPath;
+ (void)DBCopy:(NSString *)_destPath;
+ (NSString *)returnConfigFilePathOfApplication;

@end
