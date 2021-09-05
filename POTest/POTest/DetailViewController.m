//
//  DetailViewController.m
//  POTest
//
//  Created by Thai Nguyen Quang on 9/5/21.
//

#import "DetailViewController.h"
#import "InvoiceDB.h"
#import "ItemDB.h"
#import "OrderModel.h"
#import "ItemModel.h"
#import "InvoiceModel.h"
#import "ItemsAddViewController.h"
#import "Constants.h"
#import "BSAppDBManager.h"
#import "ItemsCell.h"
#import "MBProgressHUD.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

NSDictionary *tableViewData;
NSArray      *keys;
NSMutableArray *invoiceList;
NSMutableArray *itemList;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [ self.ItemsTableView registerNib:[UINib nibWithNibName:[ItemsCell identifier] bundle:nil] forCellReuseIdentifier:[ItemsCell identifier]];
    self.ItemsTableView.delegate   = self;
    self.ItemsTableView.dataSource = self;
    self.ItemsTableView.estimatedRowHeight = 80;
    self.ItemsTableView.rowHeight = UITableViewAutomaticDimension;
    
    itemList = [NSMutableArray new];
    invoiceList = [NSMutableArray new];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
  [super viewWillAppear:animated];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading orders...";
    
    keys = [NSArray arrayWithObjects:@"ITEMS", @"INVOICES", nil];
  __block   NSMutableArray *invoices;
  __block   NSMutableArray *items;
     
     //item
     OrderModel *orderModel = [OrderModel new];
     orderModel = self.order;
     
     ItemDB *itemDB = [ItemDB new];
     InvoiceDB *invoiceDB = [InvoiceDB new];
     
     __weak typeof(self) weak_self = self;
     
       dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
           
           [[BSAppDBManager sharedDatabaseManager] inDatabase: ^{
               items    = [itemDB getItemsWithOrderID:[orderModel.orderId intValue]];
               invoices =  [invoiceDB getInvoicesbyOrderId:1];
        
           }];
           dispatch_async(dispatch_get_main_queue(), ^(void){
               tableViewData = @{@"ITEMS": items,  @"INVOICES": invoices};
               invoiceList = invoices;
               itemList = items;
               [hud hideAnimated:YES];
               [weak_self.ItemsTableView reloadData];
                
           });
       });
}

- (IBAction)addNewItem:(id)sender {
    
    ItemsAddViewController *itemAddViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ItemsAddViewController class])];
    itemAddViewController.order = self.order;
    if (@available(iOS 13.0, *)) {
        [itemAddViewController setModalPresentationStyle: UIModalPresentationFullScreen];
    } else {
        // Fallback on earlier versions

    }
    [self presentViewController:itemAddViewController animated:true completion:nil];
}

- (IBAction)Close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0){
        return itemList.count;
    }
    else{
        return invoiceList.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *headerTitle = keys[section];
   
    return headerTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemsCell *cell = (ItemsCell *)[tableView dequeueReusableCellWithIdentifier:[ItemsCell identifier]];
    if (cell) {
        if(indexPath.section ==0){ //item
            ItemModel *item = [ItemModel new];
            item = (ItemModel *)itemList[indexPath.row];
            [cell updateWithItem:item.order_itemId Quanlity:item.order_item_quantity];
            return cell;
        }
        else{ //invoice
            InvoiceModel *invoice = [InvoiceModel new];
            invoice = (InvoiceModel *)invoiceList[indexPath.row];
            [cell updateWithInvoice:invoice.invoiceNumber Status:invoice.invoiceReceivedStatus];
             return cell;
        }
    }

    return [[UITableViewCell alloc] init];
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
