//
//  WTWeatherDataModel.h
//  WeatherTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property (nonatomic) NSString *orderId;
@property (nonatomic) NSString *deliveryNote;
@property (nonatomic) NSString *lastUpDated;
@property (nonatomic) NSString *orderDescription;
@property (nonatomic) NSString *orderSupplier;
@property (nonatomic) NSString *itemQuantity;

@end

NS_ASSUME_NONNULL_END
