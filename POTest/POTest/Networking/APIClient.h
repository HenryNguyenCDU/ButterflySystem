//
//  APIClient.h
//  WeatherTest
//
//  Created by Henry on 26/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIClient : NSObject

+(id)shared;


- (void)getPOWithSuccess:(void (^)(NSArray<OrderDataModel*>* orders))success
                 failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
