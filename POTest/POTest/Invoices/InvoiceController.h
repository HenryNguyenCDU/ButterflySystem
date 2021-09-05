//
//  ItemsQueriesController.h
//  POTest
//
//  Created by Henry Nguyen Quang on 9/1/21.
//

#import <UIKit/UIKit.h>
#import "InvoiceStatus.h"

@class InvoiceModel;

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceController : UIViewController

@property (nonatomic, weak) id<InvoiceStatus> invoiceDelegate;

- (void)saveInvoice:(NSMutableArray<InvoiceModel*>*)invoices;

- (NSMutableArray<InvoiceModel *> *)searchInvoicesByOrderId:(int)_orderId;
@end

NS_ASSUME_NONNULL_END
