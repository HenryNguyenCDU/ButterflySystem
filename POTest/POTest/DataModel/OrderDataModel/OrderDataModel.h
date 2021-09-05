
//  Copyright © 2021 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDataModel : NSObject

@property (nonatomic) NSString *orderId;
@property (nonatomic) NSString *delivery_note;
@property (nonatomic) NSString *supplier_id;
@property (nonatomic) NSString *last_updated;
@property (nonatomic) NSString *status;
@property (nonatomic) NSMutableDictionary *items;
@property (nonatomic) NSMutableDictionary *invoices;

+ (id)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
