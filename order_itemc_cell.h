//
//  order_itemc_cell.h
//  servicesprovaider
//
//  Created by MACOS on 4/11/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface order_itemc_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *i_name;
@property (strong, nonatomic) IBOutlet UILabel *tc_type;
@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UILabel *quntity;


@end
