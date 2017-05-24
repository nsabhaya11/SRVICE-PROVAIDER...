//
//  order_cell.h
//  servicesprovaider
//
//  Created by MACOS on 4/11/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface order_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *order_id;
@property (strong, nonatomic) IBOutlet UILabel *order_address;

@end
