//
//  WTorderDataModel.m
//  orderTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import "ItemModel.h"


@interface ItemModel()

@end

@implementation ItemModel

- (id)init{
    
    if (self = [super init]) {
        
        self.order_itemId           = @"";
        self.orderId                = @"";
        self.order_item_productId   = @"";
        self.order_item_quantity    = @"";
        self.order_item_lastUpdated = @"";
        self.order_item_description = @"";
    }
    return self;
}


@end
