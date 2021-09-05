
//  Created by Henry on 01/09/21.
//  Copyright © 2021 . All rights reserved.
//

#import "OrderModel.h"

@interface OrderModel()

@end

@implementation OrderModel



- (id)init{
    
    if (self = [super init]) {
        
        self.orderId            =  @"";
        self.deliveryNote       =  @"";
        self.lastUpDated        = @"";
        self.orderDescription   = @"";
        self.orderSupplier      = @"";
        self.itemQuantity       = @"";

    }
    return self;
}


@end
