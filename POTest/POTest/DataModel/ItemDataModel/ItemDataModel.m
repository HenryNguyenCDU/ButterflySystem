//
//  WTWeatherDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "ItemDataModel.h"

@interface ItemDataModel()

@end

@implementation ItemDataModel

static NSString *kId = @"id";
static NSString *kQuantity = @"quantity";
static NSString *kProduct_item_id = @"product_item_id";
static NSString *kLast_updated = @"last_updated";

+ (id)initWithDictionary:(NSDictionary*)dictionary {
    
    ItemDataModel *item = [[ItemDataModel alloc] init];

    if (self) {
        if (dictionary[kId] != [NSNull null]) {
            item.itemId = [NSString stringWithFormat:@"%@", dictionary[kId]];           
        }
        if (dictionary[kQuantity] != [NSNull null]) {
            item.quantity =  [NSString stringWithFormat:@"%@", dictionary[kQuantity]];
        }
        if (dictionary[kLast_updated] != [NSNull null]) {
            item.last_updated = [NSString stringWithFormat:@"%@", dictionary[kLast_updated]];
        }
        if (dictionary[kProduct_item_id] != [NSNull null]) {
            item.product_item_id = [NSString stringWithFormat:@"%@", dictionary[kProduct_item_id]];
        }
    }

    return item;
}

@end
