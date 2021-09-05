//
//  WTWeatherDataModel.h
//  WeatherTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : NSObject

@property (nonatomic) NSString *order_itemId;
@property (nonatomic) NSString *orderId;
@property (nonatomic) NSString *order_item_productId;
@property (nonatomic) NSString *order_item_quantity;
@property (nonatomic) NSString *order_item_lastUpdated;
@property (nonatomic) NSString *order_item_description;
@end

NS_ASSUME_NONNULL_END
