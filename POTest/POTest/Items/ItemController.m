//
//  ISAppCompaniesController.m
//  InspectionApp
//
//  Created by Hanh on 11/16/15.
//  Copyright © 2015 Onix. All rights reserved.
//

#import "ItemController.h"
#import "OrderModel.h"
#import "OrderDB.h"
#import "ItemDB.h"
#import "ItemModel.h"
#import "BSAppDBManager.h"
   

@implementation ItemController



- (NSMutableArray <ItemModel*> *)getItems{
    
    return [NSMutableArray new];
}

- (void)saveItems:(NSMutableArray <ItemModel*> *)_items :(NSMutableArray<OrderModel*> *)_orders{
    __weak typeof(self) weak_self = self;
        [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
            ItemDB* itemDB = [ItemDB new];
            [itemDB addOrUpdateOrderItem:_items];
            
            //get Item and update order;
            OrderModel *order = [OrderModel new];
            order = _orders[0];
            NSMutableArray *items = [weak_self getItemByOrderId:order.orderId];
            int number_of_items = (int)items.count;
            order.itemQuantity = [NSString stringWithFormat:@"%i", number_of_items];
            NSMutableArray *newOrder = [NSMutableArray arrayWithObject:order];
            OrderDB* orderDB = [OrderDB new];
            [orderDB addOrUpdateOrder:newOrder];
        }];

}

- (NSMutableArray *)getItemByOrderId:(NSString *)_orderId{
    __block NSMutableArray *result = [NSMutableArray array];;
   // [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
        ItemDB* itemDB = [ItemDB new];
        result = [itemDB getItemsWithOrderID:[_orderId intValue]];
  //  }];
    
    return result;
}
@end
