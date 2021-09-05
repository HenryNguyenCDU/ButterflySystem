//
//  WTWeatherDataModel.h
//  WeatherTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceModel : NSObject

@property (nonatomic) NSString *invoiceId;
@property (nonatomic) NSString *invoiceOrderId;
@property (nonatomic) NSString *invoiceNumber;
@property (nonatomic) NSString *invoiceReceivedStatus;
@property (nonatomic) NSString *invoiceLastUpdated;
@property (nonatomic) NSString *invoiceProductId;

@end

NS_ASSUME_NONNULL_END
