//
//  ISAppCompaniesController.h
//  InspectionApp
//
//  Created by Hanh on 11/16/15.
//  Copyright © 2015 Onix. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemModel;
@class OrderModel;
@interface ItemController : NSObject

- (NSMutableArray <ItemModel*> *)getItems;
- (void)saveItems:(NSMutableArray <ItemModel*> *)_items :(NSMutableArray<OrderModel*> *)_orders;
- (NSMutableArray *)getItemById:(NSString *)_itemId;

@end

