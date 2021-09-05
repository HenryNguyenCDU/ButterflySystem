//
//  Constants.h
//  SampleAppiOS
//
//  Created by Henry Nguyen Quang on 7/31/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Constants_h
#define Constants_h
#define _doInBackgroundQueue(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{block})
#define _doInMainQueue(block) dispatch_async(dispatch_get_main_queue(), ^{block})

#define KURL   @"https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
#define DEFAULT_VALUE_DATE           @"0100-01-31T00:00:00"

static  NSString *TABLE_ORDER         = @"ORDER";
static  NSString *TABLE_ITEM          = @"ORDER_ITEM";
static  NSString *TABLE_INVOICE       = @"INVOICE";
static  NSString *TABLE_PRODUCT       = @"PRODUCT";
#endif /* Constants_h */

