//
//  WTWeathersDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "ItemsDataModel.h"

@implementation ItemsDataModel


+ (id)initWithDictionary:(NSMutableDictionary *)dictionary {
    
    ItemsDataModel *items = [[ItemsDataModel alloc] init];

    NSMutableDictionary *list = dictionary;

        NSMutableArray<ItemDataModel*>* arrayItem = [NSMutableArray array];

        for (NSDictionary *itemDictionary in list) {
            ItemDataModel *itemDataModel = [ItemDataModel initWithDictionary:itemDictionary];
            [arrayItem addObject:itemDataModel];
        }

    items.items = arrayItem;

    return items;
}

@end
