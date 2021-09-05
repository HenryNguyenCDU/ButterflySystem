//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderStatus <NSObject>

@optional

- (void) OrderUpdateSuccess;
- (void) OrderFailed:(NSString *)error;

@end


