//
//  ISAppSQL.h
//  Demo Butterfly
//
//  Created by Henry Nguyen.
//  Copyright (c)  BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSAppSQL : NSObject

@property (retain, nonatomic) NSString *Order;
@property (retain, nonatomic) NSString *OrderItem;
//@property (retain, nonatomic) NSString *Item;
@property (retain, nonatomic) NSString *Product;
@property (retain, nonatomic) NSString *Invoice;
//@property (retain, nonatomic) NSString *Invoices;
@property (retain, nonatomic) NSString *Receipt;

- (NSDictionary *)allPropertyNames;



@end
