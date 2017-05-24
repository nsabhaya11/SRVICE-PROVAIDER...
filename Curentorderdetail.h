//
//  Curentorderdetail.h
//  servicesprovaider
//
//  Created by Admin on 14/05/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Curentorderdetail : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblview;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;
@property (weak, nonatomic) IBOutlet UILabel *totalbill;
@property (weak, nonatomic) IBOutlet UILabel *paymentstatus;
@property (weak, nonatomic) IBOutlet UILabel *address;
- (IBAction)Complitorder:(id)sender;


@end
