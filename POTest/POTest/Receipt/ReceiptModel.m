//
//  WTorderDataModel.m
//  orderTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import "ReceiptModel.h"

@interface ReceiptModel()

@end

@implementation ReceiptModel

- (id)init{
    
    if (self = [super init]) {
        
        self.receiptId   = @"";
        self.productId   = @"";
        self.quantity    = @"";
        self.lastUpdated = @"";
        self.invoiceId   = @"";
    }
    return self;
}


@end
