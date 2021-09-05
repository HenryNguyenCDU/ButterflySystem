
//  Copyright © 2021 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemDataModel : NSObject

@property (nonatomic) NSString *itemId;
@property (nonatomic) NSString *quantity;
@property (nonatomic) NSString *product_item_id;
@property (nonatomic) NSString *last_updated;


+ (id)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
