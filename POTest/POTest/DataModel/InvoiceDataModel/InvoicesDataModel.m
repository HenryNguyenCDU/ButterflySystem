//
//  WTWeathersDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "InvoicesDataModel.h"

@implementation InvoicesDataModel

+ (id)initWithDictionary:(NSMutableDictionary *)dictionary {
    
    InvoicesDataModel *invoices = [[InvoicesDataModel alloc] init];

  
    NSMutableDictionary *list = dictionary;

        NSMutableArray<InvoiceDataModel*>* arrayInvoice = [NSMutableArray array];

        for (NSDictionary *invoiceDictionary in list) {
            InvoiceDataModel *invoiceDataModel = [InvoiceDataModel initWithDictionary:invoiceDictionary];
            [arrayInvoice addObject:invoiceDataModel];
        }

    invoices.invoices = arrayInvoice;

    return invoices;
}

@end
