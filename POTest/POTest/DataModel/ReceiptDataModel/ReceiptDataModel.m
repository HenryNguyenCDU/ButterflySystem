//
//  WTWeatherDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "ReceiptDataModel.h"

@interface ReceiptDataModel()

@end

@implementation ReceiptDataModel

static NSString *kId = @"id";
static NSString *kProduct_item_id= @"product_item_id";
static NSString *kReceived_quantity = @"received_quantity";
static NSString *kLast_updated = @"last_updated";
static NSString *kCreated= @"created";

+ (id)initWithDictionary:(NSDictionary *)dictionary {
    
    ReceiptDataModel *receipt = [[ReceiptDataModel alloc] init];

    if (self) {
        if (dictionary[kId] != [NSNull null]) {
            receipt.receiptId = [NSString stringWithFormat:@"%@", dictionary[kId]];
        }

        if (dictionary[kProduct_item_id] != [NSNull null]) {
            receipt.product_item_id = [NSString stringWithFormat:@"%@", dictionary[kProduct_item_id]];
        }

        if (dictionary[kReceived_quantity] != [NSNull null]) {
            receipt.received_quantity = [NSString stringWithFormat:@"%@", dictionary[kReceived_quantity]];
        }

        if (dictionary[kLast_updated] != [NSNull null]) {
            receipt.last_updated = [NSString stringWithFormat:@"%@", dictionary[kLast_updated]];
        }
        if (dictionary[kCreated] != [NSNull null]) {
            receipt.created = [NSString stringWithFormat:@"%@", dictionary[kCreated]];
        }


    }

    return receipt;
}

@end
