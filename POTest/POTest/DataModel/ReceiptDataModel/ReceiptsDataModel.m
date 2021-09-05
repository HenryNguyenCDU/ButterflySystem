//
//  WTWeathersDataModel.m
//  WeatherTest
//
//  Created by Andrea Sanchez Roman on 27/02/20.
//  Copyright © 2020 Melexia. All rights reserved.
//

#import "ReceiptsDataModel.h"

@implementation ReceiptsDataModel

static NSString *kCount = @"count";
static NSString *kList = @"list";

+ (id)initWithDictionary:(NSMutableDictionary *)dictionary {
    ReceiptsDataModel *receipts = [[ReceiptsDataModel alloc] init];

    NSMutableDictionary *list = dictionary;

        NSMutableArray<ReceiptDataModel*>* arrayReceipt= [NSMutableArray array];

        for (NSDictionary *receiptDictionary in list) {
            ReceiptDataModel *receiptDataModel = [ReceiptDataModel initWithDictionary:receiptDictionary];
            [arrayReceipt addObject:receiptDataModel];
        }

    receipts.receipts = arrayReceipt;

    return receipts;
}

@end
