//
//  WTorderDataModel.m
//  orderTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import "ProductModel.h"

@interface ProductModel()

@end

@implementation ProductModel

- (id)init{
    
    if (self = [super init]) {
        
        self.productId            = @"";
        self.lastUpdated          = @"";
        self.productDescription   = @"";
    }
    return self;
}


@end
