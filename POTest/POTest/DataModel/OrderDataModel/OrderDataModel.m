//
//  WTWeatherDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "OrderDataModel.h"

@interface OrderDataModel()

@end

@implementation OrderDataModel

static NSString *kId = @"id";
static NSString *kItems = @"items";
static NSString *kInvoices = @"invoices";
static NSString *kStatus = @"status";
static NSString *kLast_updated = @"last_updated";
static NSString *kSupplier_id = @"supplier_id";
static NSString *kDeliveryNote = @"delivery_note";

+ (id)initWithDictionary:(NSDictionary *)dictionary {
    
    OrderDataModel *order = [[OrderDataModel alloc] init];

    if (self) {
        
        if (dictionary[kId] != [NSNull null]) {
            order.orderId = [NSString stringWithFormat:@"%@", dictionary[kId]];
        }

        if (dictionary[kStatus] != [NSNull null]) {
            order.status =   [NSString stringWithFormat:@"%@", dictionary[kStatus]];
        }
        if (dictionary[kLast_updated] != [NSNull null]) {
            order.last_updated =  [NSString stringWithFormat:@"%@", dictionary[kLast_updated]];
        }
        if (dictionary[kSupplier_id] != [NSNull null]) {
            order.supplier_id = [NSString stringWithFormat:@"%@", dictionary[kSupplier_id]];
        }
        
        if (dictionary[kDeliveryNote] != [NSNull null]) {
            order.delivery_note = [NSString stringWithFormat:@"%@", dictionary[kDeliveryNote]];
        }
        if (dictionary[kInvoices] != [NSNull null]) {
            NSMutableDictionary *invoicesDictionary = dictionary[kInvoices] ;
            order.invoices = invoicesDictionary;
        }
        
        if (dictionary[kItems] != [NSNull null]) {
            NSMutableDictionary *itemsDictionary = dictionary[kItems];
            order.items = itemsDictionary;
        }

    }

    return order;
}

@end
