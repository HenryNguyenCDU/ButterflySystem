//
//  DetailsViewController.h
//  POTest
//
//  Created by Henry Nguyen Quang on 8/31/21.
//

#import <UIKit/UIKit.h>
#import "OrderStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrdersAddViewController : UIViewController<UITextFieldDelegate, OrderStatus>

@property (weak, nonatomic) IBOutlet UITextField *txt_orderName;
@property (weak, nonatomic) IBOutlet UITextField *txt_supplier;
@property (weak, nonatomic) IBOutlet UITextField *txt_Note;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;
@property (weak, nonatomic) IBOutlet UIButton *btn_insert10000;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;

@end

NS_ASSUME_NONNULL_END
