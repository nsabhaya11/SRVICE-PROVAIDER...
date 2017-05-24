//
//  item-insert.h
//  servicesprovaider
//
//  Created by Admin on 19/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface item_insert : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
- (IBAction)back:(id)sender;

    @property (weak, nonatomic) IBOutlet UIImageView *item_img;


- (IBAction)insert_item:(id)sender;


    

@property (weak, nonatomic) IBOutlet TextFieldValidator *item_type;
    
@property (weak, nonatomic) IBOutlet TextFieldValidator *item_name;
    
@property (weak, nonatomic) IBOutlet TextFieldValidator *item_detail;
    
@property (weak, nonatomic) IBOutlet TextFieldValidator *item_price;
    
    
@end
