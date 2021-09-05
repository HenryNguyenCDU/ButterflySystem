//
//  WTWeathersDataModel.h
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemsDataModel : NSObject

@property (nonatomic) int count;
@property (nonatomic) NSArray<ItemDataModel*> *items;

+ (id)initWithDictionary:(NSMutableDictionary*)dictionary;
@end

NS_ASSUME_NONNULL_END
