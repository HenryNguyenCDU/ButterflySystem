//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import "BSAppDBManager.h"
#import "InvoiceDB.h"


@class FMDatabase;

@implementation InvoiceDB

- (instancetype)init{
    
    if (self = [super init]) {
        
    } 
    return self;
}

- (NSMutableArray *)mapToInvoice:(FMResultSet *) resultSet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        InvoiceModel *invoice = [[InvoiceModel alloc] init];
   
        [invoice setInvoiceId:[self stringForColumn:resultSet:@"InvoiceID"]];
        [invoice setInvoiceOrderId:[self stringForColumn: resultSet: @"OrderID"]];
        [invoice setInvoiceNumber:[self stringForColumn: resultSet: @"InvoiceNumber"]];
        [invoice setInvoiceReceivedStatus:[self stringForColumn:resultSet: @"ReceivedStatus"]];
        [invoice setInvoiceLastUpdated:[self stringForColumn:resultSet: @"LastUpdated"]];
        [invoice setInvoiceProductId:[self stringForColumn:resultSet: @"InvoiceProductID"]];

        [list addObject:invoice];
    }
    return list;
}

- (void)addOrUpdateOrderInvoice:(NSMutableArray *)objList{
    
    for (int i = 0; i<objList.count; i++) {
        
        NSString *_query = @"";
        
        InvoiceModel* invoice = (InvoiceModel *)objList[i];
        NSArray *_varList = [NSArray new];
        if (!invoice.invoiceId) {
            _query =  [self buildAddOrUpdateInvoiceQuery];
            _varList = [NSArray arrayWithObjects:
                                 invoice.invoiceId,
                                 invoice.invoiceOrderId, invoice.invoiceNumber, invoice.invoiceReceivedStatus, invoice.invoiceProductId, invoice.invoiceLastUpdated, nil];
           
        }
        else{
            _query =  [self buildAddOrUpdateDefaultInvoiceQuery];
             _varList = [NSArray arrayWithObjects:
                                 invoice.invoiceOrderId, invoice.invoiceNumber, invoice.invoiceReceivedStatus, invoice.invoiceProductId, invoice.invoiceLastUpdated, nil];
            
        }
        [[BSAppDBManager sharedDatabaseManager] executeUpdateWithParameter:_query : _varList];
    }
}

- (NSMutableArray<InvoiceModel*> *)getInvoicesbyOrderId:(int)orderId {
  
    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];

    [sql appendString: @"SELECT "
      " InvoiceID ,"
      " OrderID ,"
      " InvoiceNumber ,"
      " ReceivedStatus, "
      " InvoiceProductID "
      " FROM 'INVOICE' "
      " WHERE OrderID = ?"];
    //Henry: build parameters for query
    NSArray *_varList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", orderId], nil];
    
    [[BSAppDBManager sharedDatabaseManager] executeQueryWithParameter:sql :_varList queryResBlock:^(FMResultSet *set){
        result = [self mapToInvoice:set];
    }];
    
    if(result != nil && result.count > 0)
        return result;
    else
        return nil;
}


- (NSString *)buildAddOrUpdateInvoiceQuery{
    NSString *_sql = @" "
    " Insert or Replace into "
    " 'INVOICE' ("
    " InvoiceID,"
    " OrderID,"
    " InvoiceNumber, "
    " ReceivedStatus, "
    " InvoiceProductID, "
    " LastUpdated "
    ")"
    " VALUES("
    "?, "  "?,"  "?,"  "?, " "?, " "? "
    ")";
    
    return _sql;

}

- (NSString *)buildAddOrUpdateDefaultInvoiceQuery{
    NSString *_sql = @" "
    " Insert or Replace into "
    " 'INVOICE' ("
    " OrderID,"
    " InvoiceNumber, "
    " ReceivedStatus, "
    " InvoiceProductID, "
    " LastUpdated "
    ")"
    " VALUES("
    "?, "  "?,"  "?,"  "?, " "? "
    ")";
    
    return _sql;

}

@end
