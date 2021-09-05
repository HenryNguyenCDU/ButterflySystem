//
//  ViewController.h
//  POTest
//
//  Created by Henry Nguyen Quang on 8/29/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *OrdersTableView;

@end

