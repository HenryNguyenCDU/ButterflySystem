//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//
#import "ProductDB.h"
#import "BSAppDBManager.h"

@class FMDatabase;

@implementation ProductDB

- (instancetype)init{
    
    if (self = [super init]) {
        
    } 
    return self;
}

- (NSMutableArray *)mapToProduct:(FMResultSet *) resultSet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        ProductModel *product = [[ProductModel alloc] init];
      
        [product setProductId:[self stringForColumn:resultSet: @"ProductID"]];
        [product setLastUpdated:[self stringForColumn: resultSet: @"LastUpdated"]];
        [product setProductDescription:[self stringForColumn: resultSet: @"productDescription"]];

        [list addObject:product];
    }
    return list;
}

- (void)addOrUpdateProduct:(NSMutableArray *)objList{
    for (int i = 0; i<objList.count; i++) {
        
        NSString *_query =  [self buildAddOrUpdateProductQuery];
        
        ProductModel* product = (ProductModel *)objList[i];
        
        //Henry: build parameters for query
        NSArray *_varList = [NSArray arrayWithObjects:
                             product.productId, product.lastUpdated, product.productDescription,nil];
        
        
        [[BSAppDBManager sharedDatabaseManager] executeUpdateWithParameter:_query : _varList];
    }
//    if ([_productDelegate respondsToSelector:@selector(ProductSuccess)]) {
//        [_productDelegate ProductSuccess];
//    }
}

- (ProductModel *)getProductId:(int)productId{
    //Henry: declare variables
    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    
    //Henry: build query
    [sql appendString: @"SELECT "
      " ProductID ,"
      " Description ,"
      " LastUpdated "
      " FROM PRODUCT "
      " WHERE ProductID = ?"];
    //Henry: build parameters for query
    NSArray *_varList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", productId], nil];
    
    [[BSAppDBManager sharedDatabaseManager] executeQueryWithParameter:sql :_varList queryResBlock:^(FMResultSet *set){
        result = [self mapToProduct:set];
    }];
    
    if(result != nil && result.count > 0)
        return result[0];
    else
        return nil;
}


- (NSString *)buildAddOrUpdateProductQuery{
    NSString *_sql = @" "
    " Insert or Replace into "
    " PRODUCT ( "
    " ProductID  ,"
    " LastUpdated  ,"
    " Description ) "
    " values("
    " ?    , "  "?    , "  "?   "
    " ) ";
    
    return _sql;

}
@end
