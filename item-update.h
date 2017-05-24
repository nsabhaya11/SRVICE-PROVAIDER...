//
//  item-update.h
//  servicesprovaider
//
//  Created by Admin on 07/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface item_update : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img;
;
@property (weak, nonatomic) IBOutlet TextFieldValidator *item_name;
@property (weak, nonatomic) IBOutlet TextFieldValidator *item_detail;
@property (weak, nonatomic) IBOutlet TextFieldValidator *item_pric;
- (IBAction)update_item:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *item_type;

@end
