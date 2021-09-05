//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//
#import "ReceiptDB.h"
#import "BSAppDBManager.h"

@class FMDatabase;

@implementation ReceiptDB

- (instancetype)init{
    
    if (self = [super init]) {
        
    } 
    return self;
}

- (NSMutableArray *)mapToReceipt:(FMResultSet *) resultSet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        ReceiptModel *receipt = [[ReceiptModel alloc] init];
      
        [receipt setReceiptId:[self stringForColumn:resultSet: @"receiptId"]];
        [receipt setProductId:[self stringForColumn: resultSet: @"productId"]];
        [receipt setQuantity:[self stringForColumn: resultSet: @"quantity"]];
        [receipt setLastUpdated:[self stringForColumn: resultSet: @"lastUpdated"]];

        [list addObject:receipt];
    }
    return list;
}

- (void)addOrUpdateReceipt:(NSMutableArray *)objList{
    for (int i = 0; i<objList.count; i++) {
        

        NSString *_query =  [self buildAddOrUpdateProductQuery];
        
        ReceiptModel* receipt = (ReceiptModel *)objList[i];
        
        //Henry: build parameters for query
        NSArray *_varList = [NSArray arrayWithObjects:
                             receipt.productId,  receipt.invoiceId ,receipt.quantity, receipt.lastUpdated,nil];
        
        
        [[BSAppDBManager sharedDatabaseManager] executeUpdateWithParameter:_query : _varList];
    }
//    if ([_productDelegate respondsToSelector:@selector(ProductSuccess)]) {
//        [_productDelegate ProductSuccess];
//    }
}

- (ReceiptModel *)getReceiptId:(int)productId{
    //Henry: declare variables
    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    
    //Henry: build query
    [sql appendString: @"SELECT "
      " ReceiptID ,"
      " ProductID ,"
      " InvoiceID ,"
      " Quantity ,"
      " LastUpdated "
      " FROM RECEIPT "
      " WHERE 'InvoiceID' = ?"];
    //Henry: build parameters for query
    NSArray *_varList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", productId], nil];
    
    [[BSAppDBManager sharedDatabaseManager] executeQueryWithParameter:sql :_varList queryResBlock:^(FMResultSet *set){
        result = [self mapToReceipt:set];
    }];
    
    if(result != nil && result.count > 0)
        return result[0];
    else
        return nil;
}


- (NSString *)buildAddOrUpdateProductQuery{
    NSString *_sql = @" "
    " Insert or Replace into "
    " 'RECEIPT' ( "
    " ProductID  ,"
    " InvoiceID  ,"
    " Quantity  ,"
    " LastUpdated"
    ") "
    " values("
    " ?    , "  "?    , "  "?,   " "?   "
    " ) ";
    
    return _sql;

}
@end
