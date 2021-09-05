
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemStatus <NSObject>

@optional

- (void) ItemUpdateSuccess;
- (void) ItemFailed:(NSString *)error;

@end


