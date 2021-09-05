//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "BSAppBaseDB.h"
#import "OrderStatus.h"

@interface OrderDB :BSAppBaseDB

@property (nonatomic, weak) id<OrderStatus> orderDelegate;

- (void)addOrUpdateOrder:(NSMutableArray *)_objList;
- (OrderModel *)getOrderById:(int)orderId;
- (NSMutableArray<OrderModel*> *)getOrders;
@end
