//
//  DetailsViewController.h
//  POTest
//
//  Created by Henry Nguyen Quang on 8/31/21.
//

#import <UIKit/UIKit.h>
#import "ItemStatus.h"
@class OrderModel;

NS_ASSUME_NONNULL_BEGIN

@interface ItemsAddViewController : UIViewController<UITextFieldDelegate, ItemStatus>
@property (weak, nonatomic) IBOutlet UITextField *txt_itemDesc;
@property (weak, nonatomic) IBOutlet UITextField *txt_quantity;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;
@property (weak, nonatomic) IBOutlet UIButton *btn_save10000;

@property (weak, nonatomic) IBOutlet UITextField *txt_productID;

@property OrderModel *order;
@end

NS_ASSUME_NONNULL_END
