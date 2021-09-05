//
//  WTWeathersDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "OrdersDataModel.h"

@implementation OrdersDataModel


+ (id)initWithDictionary:(NSMutableDictionary*)dictionary {
    
    OrdersDataModel *orders = [[OrdersDataModel alloc] init];

        NSMutableDictionary *list = dictionary;

        NSMutableArray<OrderDataModel*>* arrayOrder = [NSMutableArray array];

        for (NSDictionary *orderDictionary in list) {
            OrderDataModel *orderDataModel = [OrderDataModel initWithDictionary:orderDictionary];
            [arrayOrder addObject:orderDataModel];
        }

    orders.orders = arrayOrder;

    return orders;
}

@end
