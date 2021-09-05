//
//  ISAppCompaniesController.h
//  InspectionApp
//
//  Created by Hanh on 11/16/15.
//  Copyright © 2015 Onix. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderModel;

@interface OrderController : NSObject

- (NSMutableArray <OrderModel*> *)getOrders;
- (void )saveOrders:(NSMutableArray <OrderModel*> *)_orders;
- (OrderModel *)getOrderById:(NSString *)_orderId;

- (void)downloadOrders:(void (^)(BOOL success, id result))complete
                 error:(void (^)(NSError *error))failure;
@end

