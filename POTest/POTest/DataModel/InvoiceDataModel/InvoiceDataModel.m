//
//  WTWeatherDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "InvoiceDataModel.h"

@interface InvoiceDataModel()

@end

@implementation InvoiceDataModel

static NSString *kId = @"id";
static NSString *kInvoice_number = @"invoice_number";
static NSString *kCreated = @"created";
static NSString *kLast_updated = @"last_updated";

static NSString *kReceipts = @"receipts";

+ (id)initWithDictionary:(NSDictionary *)dictionary {
    
    InvoiceDataModel *invoice = [[InvoiceDataModel alloc] init];

    if (self) {
        if (dictionary[kId] != [NSNull null]) {
            invoice.invoiceId =  [NSString stringWithFormat:@"%@", dictionary[kId]];
        }

        if (dictionary[kInvoice_number] != [NSNull null]) {
            invoice.invoice_number =   [NSString stringWithFormat:@"%@", dictionary[kInvoice_number]];
        }

        if (dictionary[kLast_updated] != [NSNull null]) {
            invoice.last_updated = [NSString stringWithFormat:@"%@", dictionary[kLast_updated]];
        }

        if (dictionary[kCreated] != [NSNull null]) {
            invoice.created =  [NSString stringWithFormat:@"%@", dictionary[kCreated]];
        }

        if (dictionary[kReceipts] != [NSNull null]) {
            NSMutableDictionary *receiptDictionary = dictionary[kReceipts] ;
            invoice.receipts = receiptDictionary;
        }

    }

    return invoice;
}

@end
