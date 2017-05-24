//
//  order_item_vc.h
//  servicesprovaider
//
//  Created by MACOS on 4/11/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface order_item_vc : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tbl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *paymentstatus;
@property (weak, nonatomic) IBOutlet UILabel *address;


@end
