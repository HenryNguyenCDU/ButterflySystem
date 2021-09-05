//
//  ISAppSQL.m
//  Demo Butterfly
//
//  Created by Henry Nguyen
//  Copyright (c)  BB. All rights reserved.
//

#import "BSAppSQL.h"
#import <objc/runtime.h>

@implementation BSAppSQL

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.Order = @"CREATE TABLE"
        " 'ORDER'("
        " OrderID INTEGER PRIMARY KEY AUTOINCREMENT,"
        " DeliveryNote TEXT,"
        " Supplier INTEGER,"
        " Description TEXT,"
        " LastUpdated TEXT, "
        " ItemQuantity INTEGER"
        " );";
        
        self.OrderItem = @"CREATE TABLE"
        " 'ORDER_ITEM' ("
        " Order_ItemID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        " OrderID INTEGER ,"
        " ProductID INTEGER ,"
        " LastUpdated TEXT ,"
        " Description TEXT ,"
        " Quantity INTEGER "
        " );";
        
        self.Receipt = @"CREATE TABLE"
         " RECEIPT ("
         " ReceiptID INTEGER PRIMARY KEY AUTOINCREMENT,"
         " ProductID INTEGER ,"
         " InvoiceID INTEGER ,"
         " Quantity INTEGER ,"
         " LastUpdated TEXT "
         " );";
        
        self.Product = @"CREATE TABLE"
         " 'PRODUCT' ("
         " ProductID INTEGER PRIMARY KEY AUTOINCREMENT,"
         " LastUpdated TEXT, "
         " ItemID INTEGER, "
        "  Description TEXT "
         " );";
        
        self.Invoice = @"CREATE TABLE"
         " 'INVOICE' ("
         " InvoiceID INTEGER PRIMARY KEY AUTOINCREMENT,"
         " OrderID INTEGER ,"
         " InvoiceNumber INTEGER ,"         
         " ReceivedStatus TEXT ,"
         " InvoiceProductID INTEGER ,"
         " LastUpdated TEXT"
//         " PRIMARY KEY(InvoiceId)"
         " );";
    }
    return self;
}

- (NSDictionary *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *value = [self valueForKey:key];
        if (value){
            [dictionary setObject:value forKey:key] ;
        }
    }
    
    free(properties);

    return dictionary;
}


@end
