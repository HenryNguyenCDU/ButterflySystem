//
//  WTorderDataModel.m
//  orderTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import "InvoiceModel.h"


@interface InvoiceModel()

@end

@implementation InvoiceModel

- (id)init{
    
    if (self = [super init]) {
        
        self.invoiceId              = @"";
        self.invoiceOrderId         = @"";
        self.invoiceNumber          = @"";
        self.invoiceReceivedStatus  = @"";
        self.invoiceLastUpdated     = @"";
        self.invoiceProductId       = @"";

    }
    return self;
}


@end
