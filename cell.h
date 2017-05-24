//
//  cell.h
//  servicesprovaider
//
//  Created by Admin on 09/01/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface cell : UITableViewCell<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *item_image;
@property (strong, nonatomic) IBOutlet UITextField *item_name;
@property (strong, nonatomic) IBOutlet UITextField *item_price;
@property (strong, nonatomic) IBOutlet UIView *cotentview;

@property (weak, nonatomic) IBOutlet cell *cell1;



@property (weak, nonatomic) IBOutlet UIButton *insertbtn;



@end
