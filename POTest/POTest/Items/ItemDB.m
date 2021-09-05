//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import "BSAppDBManager.h"
#import "ItemDB.h"

@class FMDatabase;

@implementation ItemDB

- (instancetype)init{
    
    if (self = [super init]) {
        
    } 
    return self;
}

- (NSMutableArray *)mapToItem:(FMResultSet *) resultSet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        ItemModel *item = [[ItemModel alloc] init];
   
        [item setOrder_itemId:[self stringForColumn:resultSet: @"Order_ItemID"]];
        [item setOrderId:[self stringForColumn: resultSet: @"OrderID"]];
        [item setOrder_item_lastUpdated:[self stringForColumn: resultSet: @"LastUpdated"]];
        [item setOrder_item_productId:[self stringForColumn:resultSet: @"ProductID"]];
        [item setOrder_item_quantity:[self stringForColumn:resultSet: @"Quantity"]];
        [item setOrder_item_description:[self stringForColumn:resultSet: @"Description"]];
        [list addObject:item];
    }
    return list;
}

- (void)addOrUpdateOrderItem:(NSMutableArray *)objList{
    
    for (int i = 0; i<objList.count; i++) {
        

        NSString *_query =  [self buildAddOrUpdateItemQuery];
        
        ItemModel* order_item = (ItemModel *)objList[i];
        
        //Henry: build parameters for query
        NSArray *_varList = [NSArray arrayWithObjects:
                   order_item.orderId, order_item.order_item_productId,  order_item.order_item_quantity, order_item.order_item_description, order_item.order_item_lastUpdated,  nil];
        
        
        [[BSAppDBManager sharedDatabaseManager] executeUpdateWithParameter:_query : _varList];
    }
//    if ([_itemDelegate respondsToSelector:@selector(ItemSuccess)]) {
//        [_itemDelegate ItemSuccess];
//    }
}

- (NSMutableArray<ItemModel*> *)getItemsWithOrderID:(int)orderId{
    //Henry: declare variables
    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    
    //Henry: build query
    [sql appendString: @"SELECT "
      " Order_ItemID ,"
      " OrderID ,"
      " LastUpdated ,"
     // " ProductID ,"
      " Quantity ,"
      " Description "
      " FROM ORDER_ITEM "
      " WHERE OrderID = ?"];
    //Henry: build parameters for query
    NSArray *_varList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", orderId], nil];
    
    [[BSAppDBManager sharedDatabaseManager] executeQueryWithParameter:sql :_varList queryResBlock:^(FMResultSet *set){
        result = [self mapToItem:set];
    }];
    
    if(result != nil && result.count > 0)
        return result;
    else
        return [NSMutableArray new];
}


- (NSString *)buildAddOrUpdateItemQuery{
    NSString *_sql = @" "
    " Insert or Replace into "
    " 'ORDER_ITEM' ("
  //  " Order_ItemID, "
    " OrderID,"
    " ProductID, "
    " Quantity, "
    " Description, "
    " LastUpdated "
    ")"
    " VALUES("
    "?, "  "?, "  "?,"  "?,"  "?"
    ")";
    
    return _sql;

}
@end
