//
//  offer-update.h
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface offer_update : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)back:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet TextFieldValidator *offer_name;

@property (weak, nonatomic) IBOutlet TextFieldValidator *old_price;
@property (weak, nonatomic) IBOutlet TextFieldValidator *n_price;
- (IBAction)upadte:(id)sender;
@property (weak, nonatomic) IBOutlet TextFieldValidator *offer_detail;

@end
