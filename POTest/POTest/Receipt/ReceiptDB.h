//

//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiptModel.h"
#import "BSAppBaseDB.h"

@interface ReceiptDB :BSAppBaseDB

//@property (nonatomic, weak) id<ProductStatus> _productDelegate;

- (void)addOrUpdateReceipt:(NSMutableArray *)objList;
- (ReceiptModel *)getReceiptId:(int)receiptId;
@end

