//
//  WTWeathersDataModel.h
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrdersDataModel : NSObject


@property (nonatomic) NSArray<OrderDataModel*> *orders;

+ (id)initWithDictionary:(NSMutableDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
