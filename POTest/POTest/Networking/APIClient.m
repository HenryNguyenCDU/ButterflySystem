//
//  APIClient.m
//  WeatherTest
//
//  Created by Henry on 26/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import "APIClient.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "OrdersDataModel.h"

//#define _doInBackgroundQueue(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{block})
//#define _doInMainQueue(block) dispatch_async(dispatch_get_main_queue(), ^{block})

@implementation APIClient

static APIClient *sharedManager = nil;

+(id)shared {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });

    return sharedManager;
}

- (id)init {
    self = [super init];

    if (self) {
    }

    return self;
}
- (void)getPOWithSuccess:(void (^)(NSArray<OrderDataModel*>* orders))success
                 failure:(void (^)(NSError *error))failure {


    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
 
    [manager GET:KURL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _doInBackgroundQueue(OrdersDataModel *ordersDataModel = [OrdersDataModel initWithDictionary:responseObject];
                             _doInMainQueue(success(ordersDataModel.orders););
                             );
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}




@end
