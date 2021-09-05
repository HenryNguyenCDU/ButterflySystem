//
//  ItemsQueriesController.m
//  POTest
//
//  Created by Henry Nguyen Quang on 9/1/21.
//

#import "InvoiceController.h"
#import "BSAppDBManager.h"
#import "InvoiceModel.h"
#import "InvoiceDB.h"
#import "InvoiceModel.h"

@interface InvoiceController ()

@end

@implementation InvoiceController

- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

- (void)saveInvoice:(NSMutableArray<InvoiceModel *> *)invoices{
    //save order

    NSMutableArray<InvoiceModel*> *listInvoices = invoices;
    InvoiceDB* invoiceDB = [InvoiceDB new];
   
    [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
        [invoiceDB addOrUpdateOrderInvoice:listInvoices];
    }];
 //  if( [self.itemDelegate respondsToSelector:@selector(ItemUpdateSuccess)]) {
 //       [self.itemDelegate ItemUpdateSuccess];
 //  }
}

- (NSMutableArray *)searchInvoicesByOrderId:(int)_orderId{
    
    __block NSMutableArray *result = [NSMutableArray array];;
    [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
        InvoiceDB* invoiceDB = [InvoiceDB new];
        result = [invoiceDB getInvoicesbyOrderId:1];
    }];
    return result;
}

- (void)excuteQuery{

    [[BSAppDBManager sharedDatabaseManager] inTransaction: ^{
        //   NSLog(@"call method download jboreportsheets");
        //[equipmentsDB addOrUpdateEquipments:result];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
