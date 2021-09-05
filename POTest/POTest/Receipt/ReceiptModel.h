//
//  WTWeatherDataModel.h
//  WeatherTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptModel : NSObject

@property (nonatomic) NSString *receiptId;
@property (nonatomic) NSString *productId;
@property (nonatomic) NSString *invoiceId;
@property (nonatomic) NSString *quantity;
@property (nonatomic) NSString *lastUpdated;

@end

NS_ASSUME_NONNULL_END
