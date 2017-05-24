//
//  current_order_detail.h
//  servicesprovaider
//
//  Created by MACOS on 5/19/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface current_order_detail : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *paymentstatus;
@property (weak, nonatomic) IBOutlet UILabel *address;

- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrlview;
@property (strong, nonatomic) IBOutlet UITableView *tblview;
@property (strong, nonatomic) IBOutlet UILabel *price;

- (IBAction)compliteorder:(id)sender;

@end

