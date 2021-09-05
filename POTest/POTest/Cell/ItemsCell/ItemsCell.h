//
//  HomeWeatherTableViewCell.h
//  WeatherTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemsCell : UITableViewCell

+ (NSString *)identifier;

- (void)updateWithInvoice:(NSString *)_invoiceNumber Status:(NSString *)_receiveStatus;

- (void)updateWithItem:(NSString *)_itemId Quanlity:(NSString *)_quanlity;

@end

NS_ASSUME_NONNULL_END
