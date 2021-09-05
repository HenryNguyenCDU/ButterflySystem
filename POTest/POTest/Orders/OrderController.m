//
//  ISAppCompaniesController.m
//  InspectionApp
//
//  Created by Hanh on 11/16/15.
//  Copyright © 2015 Onix. All rights reserved.
//

#import "OrderController.h"
#import "OrderModel.h"
#import "OrderDB.h"
#import "InvoiceDB.h"
#import "ReceiptDB.h"

#import "ItemDB.h"
#import "ItemModel.h"
#import "ItemDataModel.h"
#import "APIClient.h"
#import "BSAppDBManager.h"

#import "InvoiceModel.h"
#import "InvoiceDataModel.h"
#import "Constants.h"

#import "Util.h"

#import "ItemController.h"
#import "InvoiceController.h"

@implementation OrderController

- (void)downloadOrders:(void (^)(BOOL success, id result))complete
                 error:(void (^)(NSError *error))failure{
    
    OrderDB *orderdb = [OrderDB new];
 __block   OrderModel *firstOrder = [OrderModel new];
    __block NSMutableArray<OrderModel*> *ordersFromDB = [NSMutableArray new];
       [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
           firstOrder = [orderdb getOrderById:1];
       }];
    
//    NSDate * now =  [NSDate date];
//
//    NSString * lastUpdated = firstOrder.lastUpDated;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//    NSDate *date = [dateFormatter dateFromString:lastUpdated];
//    NSComparisonResult result = [now compare:mile];
    
    __weak typeof(self) weak_self = self;
    if (!firstOrder) { //download
       
        [APIClient.shared getPOWithSuccess:^(NSArray<OrderDataModel *> * _Nonnull orders) {

            NSMutableArray<OrderModel*>   *orderList   = [NSMutableArray array];
            NSMutableArray<ItemModel*>    *itemList    = [NSMutableArray array];
            NSMutableArray<InvoiceModel*> *invoiceList = [NSMutableArray array];
            NSMutableArray<ReceiptModel*> *receiptList = [NSMutableArray array];
            
            for (int i =0; i<orders.count; i++) {
                OrderModel *order = [OrderModel new];
                OrderDataModel *orderDataModel = (OrderDataModel*)orders[i];
                order.orderId = orderDataModel.orderId;
                order.deliveryNote = orderDataModel.delivery_note;
                order.orderSupplier = orderDataModel.supplier_id;
                order.lastUpDated   = orderDataModel.last_updated;
                order.orderDescription   = [NSString stringWithFormat:@"Test Order %d",i ];
                
                //items
                NSMutableDictionary *items = orderDataModel.items;
                //set quatity for order
                order.itemQuantity = [NSString stringWithFormat:@"%lu",(unsigned long)items.count];
               
                    for(id key in items) {
                        int count = 0;
                        ItemModel *item = [ItemModel new];
                        item.orderId = orderDataModel.orderId;;
                        item.order_itemId = [key valueForKey:@"id"];
                        item.order_item_description = [NSString stringWithFormat:@"Test Item %d",count];
                        item.order_item_lastUpdated =  [key valueForKey:@"last_updated"];
                        item.order_item_quantity    =  [key valueForKey:@"quantity"];
                        item.order_item_productId   =  [key valueForKey:@"product_item_id"];
                        count ++;
                        [itemList addObject:item];
                    }
                
                //invoice
                NSMutableDictionary *invoices = orderDataModel.invoices;

                for(id key in invoices) {
                      InvoiceModel *invoice = [InvoiceModel new];
                      invoice.invoiceId = [key valueForKey:@"id"];
                      invoice.invoiceNumber = [key valueForKey:@"invoice_number"];
                      invoice.invoiceReceivedStatus = [key valueForKey:@"received_status"];
                      invoice.invoiceOrderId = orderDataModel.orderId;
                      invoice.invoiceLastUpdated = [key valueForKey:@"last_updated"];
                      invoice.invoiceProductId    =  @"110";
                    
                      [invoiceList addObject:invoice];
                    
                        NSMutableDictionary *receipts = [key valueForKey:@"receipts"];
                            for(id receipt in receipts) {
                                ReceiptModel *receiptModel = [ReceiptModel new];
                                receiptModel.invoiceId    =  invoice.invoiceId;
                                receiptModel.quantity     = [receipt valueForKey:@"received_quantity"];
                                receiptModel.lastUpdated  = [receipt valueForKey:@"last_updated"];
                                receiptModel.productId    = [receipt valueForKey:@"product_item_id"];
                                
                                [receiptList addObject:receiptModel];
                            }
                    
                }
                
                [orderList addObject:order];
            }
            
            //
            //save order to DB
            OrderDB   *orderDB   = [OrderDB new];
            ItemDB    *itemDB    = [ItemDB new];
            InvoiceDB *invoiceDB = [InvoiceDB new];
            ReceiptDB *receipt   = [ReceiptDB new];

            
            //get orders from DB;

            _doInBackgroundQueue(
                [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
                    [orderDB addOrUpdateOrder:orderList];
                    [itemDB addOrUpdateOrderItem:itemList];
                    [invoiceDB addOrUpdateOrderInvoice:invoiceList];
                    [receipt addOrUpdateReceipt:receiptList];
                }];
  
                                 //ordersFromDB = [self getOrders];
            _doInMainQueue(
                           complete(YES,orderList);
                           );
             );

           // complete(YES, orders);
        } failure:^(NSError * _Nonnull error) {
            failure(error);
        }];
    }
    else{
        _doInBackgroundQueue(
                             ordersFromDB = [self getOrders];

        _doInMainQueue(
                       complete(YES,ordersFromDB);
                       );
         );
    }

}

- (NSMutableArray <OrderModel*> *)getOrders1{
    
    __block NSMutableArray *result = [NSMutableArray array];;
    [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
        OrderDB* orderDB = [OrderDB new];
        result = [orderDB getOrders];
    }];
    return result;
    
  //  return [NSMutableArray new];
}

- (NSMutableArray <OrderModel*> *)getOrders{
    
    __block NSMutableArray *result = [NSMutableArray array];;
    [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
        OrderDB* orderDB = [OrderDB new];
        result = [orderDB getOrders];
    }];
    return result;
    
  //  return [NSMutableArray new];
}
- (void)saveOrders:(NSMutableArray <OrderModel*> *)_orders{
    
    InvoiceModel *invoiceModel = [InvoiceModel new];
    OrderModel   *orderModel   = [OrderModel new];
    orderModel = (OrderModel*)_orders[0];
    invoiceModel.invoiceNumber = @"101";
    invoiceModel.invoiceOrderId = orderModel.orderId;
    invoiceModel.invoiceReceivedStatus = @"1";
    invoiceModel.invoiceLastUpdated = orderModel.lastUpDated;
    invoiceModel.invoiceProductId = @"110";
    invoiceModel.invoiceOrderId =@"1";
    NSMutableArray<InvoiceModel*> *invoiceList = [NSMutableArray arrayWithObject:invoiceModel];
    
    [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
        OrderDB* orderDB = [OrderDB new];
        InvoiceDB* invoiceDB = [InvoiceDB new];
        [orderDB addOrUpdateOrder:_orders];
        [invoiceDB addOrUpdateOrderInvoice:invoiceList];
    }];
    
}
- (OrderModel *)getOrderById:(NSString *)_orderId{

    return [OrderModel new];
}

@end
