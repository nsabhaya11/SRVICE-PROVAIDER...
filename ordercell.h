//
//  ordercell.h
//  servicesprovaider
//
//  Created by MACOS on 4/11/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ordercell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *order_id;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *total_bill;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
