//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
#import "BSAppBaseDB.h"

@interface ProductDB :BSAppBaseDB

//@property (nonatomic, weak) id<ProductStatus> _productDelegate;

- (void)addOrUpdateProduct:(NSMutableArray *)_objList;
- (ProductModel *)getProductId:(int)productId;
@end

