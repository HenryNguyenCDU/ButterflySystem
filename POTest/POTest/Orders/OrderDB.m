//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import "OrderModel.h"
#import "BSAppDBManager.h"
#import "OrderDB.h"

@class FMDatabase;

@implementation OrderDB

- (instancetype)init{
    
    if (self = [super init]) {
        
    } 
    return self;
}

-(NSMutableArray *)mapToOrder:(FMResultSet *) resultSet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        OrderModel *order = [[OrderModel alloc] init];
        
        [order setOrderId:[self stringForColumn:resultSet: @"OrderID"]];
        [order setDeliveryNote:[self stringForColumn: resultSet: @"DeliveryNote"]];
        [order setLastUpDated:[self stringForColumn: resultSet: @"LastUpdated"]];
        [order setOrderDescription:[self stringForColumn: resultSet: @"Description"]];
        [order setOrderDescription:[self stringForColumn: resultSet: @"Description"]];
        [order setOrderSupplier:[self stringForColumn: resultSet: @"Supplier"]];
        [order setItemQuantity:[self stringForColumn: resultSet: @"ItemQuantity"]];
        
        [list addObject:order];
    }
    return list;
}

- (void)addOrUpdateOrder:(NSMutableArray *)objList{
    
    for (int i = 0; i<objList.count; i++) {

        NSString *_query = @"";
        OrderModel* order = (OrderModel *)objList[i];
        NSArray *_varList = [NSArray new];
       
        if ([order.orderId isEqualToString:@""]) {
            _query =  [self buildAddOrUpdateOrderQueryWithNullOrderId];
            _varList = [NSArray arrayWithObjects:
                       order.deliveryNote, order.orderSupplier,
                                 order.orderDescription,  order.lastUpDated, order.itemQuantity,
                        nil];
           
        }
        else{
            _query =  [self buildAddOrUpdateOrderQuery];
            _varList = [NSArray arrayWithObjects:
                                 order.orderId, order.deliveryNote, order.orderSupplier,
                        order.orderDescription, order.lastUpDated, order.itemQuantity, nil];
            
        }
        [[BSAppDBManager sharedDatabaseManager] executeUpdateWithParameter:_query : _varList];
    }
   // if ([_orderDelegate respondsToSelector:@selector(OrderUpdateSuccess)]) {
   //     [_orderDelegate OrderUpdateSuccess];
  //  }
}

- (OrderModel *)getOrderById:(int)orderId{
    //Henry: declare variables
    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];

    //Henry: build query
    [sql appendString: @"SELECT "
      " OrderID ,"
   //   " deliveryNote ,"
   //   " Supplier ,"
      " LastUpdated, "
      " ItemQuantity "
      " FROM 'ORDER' "
      " WHERE OrderID = ?"];

    NSArray *_varList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", orderId], nil];
    
    [[BSAppDBManager sharedDatabaseManager] executeQueryWithParameter:sql :_varList queryResBlock:^(FMResultSet *set){
        result = [self mapToOrder:set];
    }];
    
    if(result != nil && result.count > 0)
        return result[0];
    else
        return nil;
}

- (NSMutableArray<OrderModel*> *)getOrders{

    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];

    [sql appendString: @"SELECT"
     " OrderID ,"
     " LastUpdated, "
     " Description, "
     " Supplier, "
     " DeliveryNote, "
     " ItemQuantity "
    " FROM 'order'"];
    [[BSAppDBManager sharedDatabaseManager] executeQuery:sql queryResBlock:^(FMResultSet *set) {
        result = [self mapToOrder:set];
    }];
    
    if(result != nil && result.count > 0)
        return result;
    else
        return nil;
}


- (NSString *)buildAddOrUpdateOrderQuery{
    NSString *_sql = @""
    " Insert OR Replace into "
    " 'ORDER' ("
    " OrderID, "
    " DeliveryNote, "
    " Supplier, "
    " Description, "
    " LastUpdated, ItemQuantity)"
    " VALUES("
    "?, "  "?, "  "?,"  " ?, " "?, " "? "
    ")";
    
    return _sql;

}

- (NSString *)buildAddOrUpdateOrderQueryWithNullOrderId{
    NSString *_sql = @""
    " Insert OR Replace into "
    " 'ORDER' ("
    " DeliveryNote, "
    " Supplier, "
    " Description, "
    " LastUpdated, ItemQuantity)"
    " VALUES("
    "?, "  "?,"  " ?, " "?, " "? "
    ")";
    
    return _sql;

}
@end
