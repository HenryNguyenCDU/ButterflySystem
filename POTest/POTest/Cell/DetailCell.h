//
//  HomeWeatherTableViewCell.h
//  WeatherTest
//
//  Created by Henry on 27/02/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailCell : UITableViewCell

+ (NSString *)identifier;

- (void)updateWithPOID:(double)poId
                items:(double)items
                lastUpdatedData:(NSString*)last_update_date;

@end

NS_ASSUME_NONNULL_END
