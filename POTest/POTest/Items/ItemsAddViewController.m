//
//  DetailsViewController.m
//  POTest
//
//  Created by Henry Nguyen Quang on 8/31/21.
//

#import "ItemsAddViewController.h"
#import "OrderController.h"
#import "OrderModel.h"
#import "Constants.h"
#import "MBProgressHUD.h"
#import "ItemController.h"
#import "ItemModel.h"
#import "Util.h"

@interface ItemsAddViewController ()

@end
MBProgressHUD  *itemHud;


@implementation ItemsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.btn_save.layer.borderColor =  [UIColor clearColor].CGColor;
    self.btn_save.layer.borderWidth = 1.20f;
    self.btn_save.layer.cornerRadius = 5; // this value vary as per your desire
    self.btn_save.clipsToBounds = YES;
    
    self.btn_save10000.layer.borderColor =  [UIColor clearColor].CGColor;
    self.btn_save10000.layer.borderWidth = 1.20f;
    self.btn_save10000.layer.cornerRadius = 5; // this value vary as per your desire
    self.btn_save10000.clipsToBounds = YES;
    
    //
    self.txt_itemDesc.delegate = self;
    self.txt_itemDesc.layer.borderColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0].CGColor;
    self.txt_itemDesc.layer.borderWidth = 1.2f;
    self.txt_itemDesc.layer.cornerRadius = 5;
    self.txt_itemDesc.clipsToBounds = YES;
    //
    self.txt_quantity.delegate = self;
    self.txt_quantity.layer.borderColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0].CGColor;
    self.txt_quantity.layer.borderWidth = 1.2f;
    self.txt_quantity.layer.cornerRadius = 5;
    self.txt_quantity.clipsToBounds = YES;
    //
   // itemController = [ItemController new];
   // itemController.itemDelegate = self;
    itemHud = [MBProgressHUD new];

}
- (IBAction)save:(id)sender {
    
    itemHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    itemHud.label.text = @"Saving orders...";
    __weak typeof(self) weak_self = self;
    
    NSString *itemDesc = self.txt_itemDesc.text;
    NSString *itemQuantity = self.txt_quantity.text;
    NSString *itemProduct = self.txt_productID.text;
    if (itemDesc.length ==0 || itemQuantity.length ==0 ){
        [itemHud hideAnimated:YES];
        [self _alert:@"The input box cannot be empty"];
        return;
    }
    OrderModel *iOrder = [OrderModel new];
    iOrder = self.order;
    NSString *orderId = iOrder.orderId ;
    
    ItemModel *item = [ItemModel new];
    item.order_item_quantity    = itemQuantity;
    item.order_item_productId   = itemProduct;
    item.order_item_description = itemDesc;
    item.orderId                = orderId;
    item.order_item_lastUpdated =  [Util setCurrentDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];

    NSMutableArray<ItemModel*>  *listItems = [NSMutableArray arrayWithObject:item];
    NSMutableArray<OrderModel*> *listOrders = [NSMutableArray arrayWithObject:self.order];
    
    ItemController *itemController = [ItemController new];
    _doInBackgroundQueue(
                         [itemController saveItems:listItems :listOrders];
    _doInMainQueue(
                   [itemHud hideAnimated:YES];
                 //  [weak_self _alert:@"Successful"];
                   [weak_self reset];
                   [weak_self action_close:self];
                   );
    );
}

- (IBAction)add10000:(id)sender {
    
    itemHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    itemHud.label.text = @"Saving orders...";
    
    OrderModel *iOrder = [OrderModel new];
    iOrder = self.order;
    NSString *orderId = iOrder.orderId ;
    
    NSMutableArray<ItemModel*> *listItems = [NSMutableArray new];
    NSMutableArray<OrderModel*> *listOrders = [NSMutableArray arrayWithObject:iOrder];
    
    for (int i =0; i<10000; i++) {
        ItemModel *item = [ItemModel new];
        item.order_item_description = @"Test Item Description";
        item.orderId = orderId;
        item.order_item_quantity    = @"99";
        item.order_item_productId   = @"99";
        item.order_item_lastUpdated =   [Util setCurrentDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        [listItems addObject:item];
    }
    __weak typeof(self) weak_self = self;
    ItemController *itemController = [ItemController new];
    _doInBackgroundQueue(          
                         [itemController saveItems:listItems :listOrders];
    _doInMainQueue(
                   [itemHud hideAnimated:YES];
                  // [weak_self _alert:@"Successful"];
                   [weak_self reset];
                   [weak_self action_close:self];
                   );
     );
}

- (void) reset{
    self.txt_quantity.text = @"";
    self.txt_itemDesc.text = @"";
    self.txt_productID.text = @"";
}
- (void)_alert: (NSString *)_text{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_text message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)action_close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
