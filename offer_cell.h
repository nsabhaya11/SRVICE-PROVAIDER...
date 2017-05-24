//
//  offer_cell.h
//  servicesprovaider
//
//  Created by Admin on 01/04/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface offer_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *offer_name;
@property (weak, nonatomic) IBOutlet UILabel *n_price;
@property (weak, nonatomic) IBOutlet UILabel *offer_detail;
@property (weak, nonatomic) IBOutlet UIButton *u_btn;

@property (weak, nonatomic) IBOutlet UILabel *o_price;
@property (weak, nonatomic) IBOutlet UIButton *deletbtn;
@property (weak, nonatomic) IBOutlet UILabel *deletlbl;

@end
