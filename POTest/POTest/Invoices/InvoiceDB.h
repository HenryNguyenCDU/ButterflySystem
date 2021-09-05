//
//  Demo Butterfly
//
//  Created by Henry Nguyen on .
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvoiceModel.h"
#import "BSAppBaseDB.h"

@interface InvoiceDB :BSAppBaseDB

//@property (nonatomic, weak) id<ItemStatus> _itemDelegate;

- (void)addOrUpdateOrderInvoice:(NSMutableArray *)_objList;

- (NSMutableArray<InvoiceModel*> *)getInvoicesbyOrderId:(int)orderId;

@end

