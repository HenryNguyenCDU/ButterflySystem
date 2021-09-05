//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemModel.h"
#import "BSAppBaseDB.h"

@interface ItemDB :BSAppBaseDB

//@property (nonatomic, weak) id<ItemStatus> _itemDelegate;

- (void)addOrUpdateOrderItem:(NSMutableArray *)_objList;
- (NSMutableArray <ItemModel*> *)getItemsWithOrderID:(int)orderId;
@end

