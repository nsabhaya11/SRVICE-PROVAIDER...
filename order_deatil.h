//
//  order_deatil.h
//  simpale contoroles examplaes
//
//  Created by Admin on 14/05/17.
//  Copyright © 2017 Nikunj Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface order_deatil : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *totalbill;
@property (weak, nonatomic) IBOutlet UITableView *tblview;
@property (weak, nonatomic) IBOutlet UILabel *paymentdetails;
@property (weak, nonatomic) IBOutlet UILabel *address;
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlview;

@end
