//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InvoiceStatus <NSObject>

@optional

- (void) InvoiceUpdateSuccess;
- (void) InvoiceFailed:(NSString *)error;

@end


