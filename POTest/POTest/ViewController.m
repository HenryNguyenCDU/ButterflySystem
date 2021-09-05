//
//  ViewController.m
//  POTest
//
//  Created by Henry Nguyen Quang on 8/29/21.
//

#import "ViewController.h"
#import "Constants.h"
#import "MBProgressHUD.h"
#import "OrdersDataModel.h"
#import "APIClient.h"
#import "DetailCell.h"
#import "OrderDataModel.h"
#import "DetailViewController.h"
#import "ItemsDataModel.h"
#import "ItemDataModel.h"
#import "OrdersAddViewController.h"
#import "OrderDB.h"
#import "OrderModel.h"
#import "ItemModel.h"
#import "ItemDB.h"
#import "OrderController.h"

//#import "productI"

@interface ViewController ()

@end
NSMutableArray *Orders;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // PurchaseOrders = [NSMutableArray new];
    //tableView delegate
    
    [ self.OrdersTableView registerNib:[UINib nibWithNibName:[DetailCell identifier] bundle:nil] forCellReuseIdentifier:[DetailCell identifier]];
    self.OrdersTableView.delegate   = self;
    self.OrdersTableView.dataSource = self;
    self.OrdersTableView.estimatedRowHeight = 80;
    self.OrdersTableView.rowHeight = UITableViewAutomaticDimension;

}

- (void)viewWillAppear:(BOOL)animated{
    
  [super viewWillAppear:animated];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading orders...";
    
    OrderController *orderController = [OrderController new];
  //  __block OrderDB* _orderDB = [OrderDB new];
    __weak typeof(self) weak_self = self;
   // __block NSMutableArray <OrderModel *> *orders = [NSMutableArray new];

    [orderController downloadOrders:^(BOOL success, id result) {
        if(success){
            Orders = result;
            _doInMainQueue([hud hideAnimated:YES];
                           [weak_self.OrdersTableView reloadData];
                           );
        }
    } error:^(NSError *error) {
        
    }];

}


//tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [Orders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:[DetailCell identifier]];

    if (cell) {
 //       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        OrderDataModel *poData = PurchaseOrders[indexPath.row];
//        NSObject *itemObj = poData.items;
//        ItemsDataModel *_itemObj = (ItemsDataModel *)itemObj;
//        NSArray *items = _itemObj.items;
        
        OrderModel *poData = Orders[indexPath.row];    
        [cell updateWithPOID:[poData.orderId doubleValue] items:[poData.itemQuantity doubleValue] lastUpdatedData:poData.lastUpDated];
        return cell;
    }

    return [[UITableViewCell alloc] init];
}

// MARK: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *order = Orders[indexPath.row];

    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailViewController class])];
   // detailViewController.orderId = order.orderId;
    detailViewController.order   = order;
    
    if (@available(iOS 13.0, *)) {
        [detailViewController setModalPresentationStyle: UIModalPresentationFullScreen];
    } else {
        // Fallback on earlier versions
       // [orderAddViewController setModalPresentationStyle: uimo];
    }
    [self presentViewController:detailViewController animated:true completion:nil];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//   return 120;
//}

// MARK: - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (IBAction)add:(id)sender {
    
    OrdersAddViewController *orderAddViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OrdersAddViewController class])];

    if (@available(iOS 13.0, *)) {
        [orderAddViewController setModalPresentationStyle: UIModalPresentationFullScreen];
    } else {
        // Fallback on earlier versions
       // [orderAddViewController setModalPresentationStyle: uimo];
    }
    [self presentViewController:orderAddViewController animated:true completion:nil];
//}
}

@end
