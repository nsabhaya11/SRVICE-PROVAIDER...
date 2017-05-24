//
//  images-cell.h
//  servicesprovaider
//
//  Created by Admin on 19/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface images_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *updatebtn;


@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *deletbtn;

@property (weak, nonatomic) IBOutlet UILabel *deletlbl;

@end
