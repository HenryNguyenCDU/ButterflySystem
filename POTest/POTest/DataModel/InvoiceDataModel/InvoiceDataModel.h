
//  Copyright © 2021 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceDataModel : NSObject

@property (nonatomic) NSString *invoiceId;
@property (nonatomic) NSString *invoice_number;
@property (nonatomic) NSString *last_updated;
@property (nonatomic) NSString *created;

@property (nonatomic) NSMutableArray *receipts;

+ (id)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
