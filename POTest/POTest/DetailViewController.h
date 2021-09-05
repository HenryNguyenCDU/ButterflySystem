//
//  DetailViewController.h
//  POTest
//
//  Created by Thai Nguyen Quang on 9/5/21.
//

#import <UIKit/UIKit.h>

@class OrderModel;

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *ItemsTableView;
@property (weak, nonatomic) IBOutlet UIButton *btn_add;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;

@property OrderModel *order;
@end

NS_ASSUME_NONNULL_END
