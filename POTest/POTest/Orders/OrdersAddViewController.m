//
//  DetailsViewController.m
//  POTest
//
//  Created by Henry Nguyen Quang on 8/31/21.
//

#import "OrdersAddViewController.h"
#import "OrderController.h"
#import "OrderModel.h"
#import "Constants.h"
#import "MBProgressHUD.h"
#import "Util.h"

@interface OrdersAddViewController ()

@end
MBProgressHUD *hud;
//OrderController *Controller;// = [OrderController new];
@implementation OrdersAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
  
}

- (void)setupView{
    
    self.btn_save.layer.borderColor =  [UIColor clearColor].CGColor;
    self.btn_save.layer.borderWidth = 1.20f;
    self.btn_save.layer.cornerRadius = 5; // this value vary as per your desire
    self.btn_save.clipsToBounds = YES;
    
    self.btn_insert10000.layer.borderColor =  [UIColor clearColor].CGColor;
    self.btn_insert10000.layer.borderWidth = 1.20f;
    self.btn_insert10000.layer.cornerRadius = 5; // this value vary as per your desire
    self.btn_insert10000.clipsToBounds = YES;
    
    //
    self.txt_Note.delegate = self;
    self.txt_Note.layer.borderColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0].CGColor;
    self.txt_Note.layer.borderWidth = 1.2f;
    self.txt_Note.layer.cornerRadius = 5;
    self.txt_Note.clipsToBounds = YES;
    //
    self.txt_supplier.delegate = self;
    self.txt_supplier.layer.borderColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0].CGColor;
    self.txt_supplier.layer.borderWidth = 1.2f;
    self.txt_supplier.layer.cornerRadius = 5;
    self.txt_supplier.clipsToBounds = YES;
    //
    self.txt_orderName.delegate = self;
    self.txt_orderName.layer.borderColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0].CGColor;
    self.txt_orderName.layer.borderWidth = 1.2f;
    self.txt_orderName.layer.cornerRadius = 5;
    self.txt_orderName.clipsToBounds = YES;

  //  Controller = [OrderController new];
 //   Controller.orderDelegate = self;
    hud = [MBProgressHUD new];
}


//tableview

- (IBAction)action_Add:(id)sender {
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving orders...";
    __weak typeof(self) weak_self = self;
    
    NSString *orderDesc = self.txt_orderName.text;
    NSString *orderSupplier = self.txt_supplier.text;
    NSString *orderNote = self.txt_Note.text;
    if (orderDesc.length ==0 || orderSupplier.length ==0 || orderNote.length ==0  ){
        [self _alert:@"The input box cannot be empty"];
        return;
    }
        
    OrderModel *order = [OrderModel new];
    order.orderDescription = orderDesc;
    order.orderId = @"";
    order.itemQuantity = @"0";
    order.deliveryNote     = orderNote;
    order.orderSupplier    = orderSupplier;
    order.lastUpDated      = [Util setCurrentDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSMutableArray<OrderModel*> *listOrders = [NSMutableArray arrayWithObject:order];
    
    OrderController *controller = [OrderController new];

    _doInBackgroundQueue([controller saveOrders:listOrders];
    _doInMainQueue([hud hideAnimated:YES];
                  // [weak_self _alert:@"Successful"];
                   [weak_self reset];
                   [weak_self action_close:self];
                   );
     );
                       
}

- (IBAction)action_add10000:(id)sender {
    
    __weak typeof(self) weak_self = self;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving orders...";
    
    NSMutableArray<OrderModel*> *listOrders = [NSMutableArray new];
    for (int i =0; i<10000; i++) {
        OrderModel *order = [OrderModel new];
        order.orderDescription = @"Test Order Description";
        order.orderId          = @"";
        order.itemQuantity     = @"0";
        order.deliveryNote     = @"Test Delivery Note";
        order.orderSupplier    = @"99";
        order.lastUpDated      = [Util setCurrentDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        [listOrders addObject:order];
    }
    OrderController *controller = [OrderController new];
    _doInBackgroundQueue([controller saveOrders:listOrders];
    _doInMainQueue([hud hideAnimated:YES];
                   //[weak_self _alert:@"Successful"];
                   [weak_self reset];
                   [weak_self action_close:weak_self];
                   );
     );

                 
}

- (void)reset{
    
    self.txt_orderName.text = @"";
    self.txt_supplier.text = @"";
    self.txt_Note.text = @"";
}

- (void) OrderUpdateSuccess{
//    __weak typeof(self) weak_self = self;
//    _doInMainQueue([hud hideAnimated:YES];
//                   [weak_self _alert:@"Successful"];
//                   [weak_self reset];
//                   );
}

- (void)_alert: (NSString *)_text{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Succcessful" message:@"" preferredStyle:UIAlertControllerStyleAlert];
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
