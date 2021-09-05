//
//  WTWeathersDataModel.h
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ReceiptDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptsDataModel : NSObject

@property (nonatomic) NSArray<ReceiptDataModel*> *receipts;

+ (id)initWithDictionary:(NSMutableDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
