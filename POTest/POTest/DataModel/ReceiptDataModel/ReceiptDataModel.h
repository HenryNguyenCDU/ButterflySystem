
//  Copyright © 2021 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptDataModel : NSObject

@property (nonatomic) NSString *receiptId;
@property (nonatomic) NSString *product_item_id;
@property (nonatomic) NSString *received_quantity;
@property (nonatomic) NSString *created;
@property (nonatomic) NSString *last_updated;

+ (id)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
