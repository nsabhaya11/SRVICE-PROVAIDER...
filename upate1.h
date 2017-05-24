//
//  upate1.h
//  servicesprovaider
//
//  Created by MACOS on 12/28/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface upate1 : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet TextFieldValidator *name;
@property (weak, nonatomic) IBOutlet TextFieldValidator *address;
@property (weak, nonatomic) IBOutlet TextFieldValidator *city;
@property (weak, nonatomic) IBOutlet TextFieldValidator *street;
- (IBAction)update_licecencepic:(id)sender;
@property (weak, nonatomic) IBOutlet TextFieldValidator *pincoad;
@property (weak, nonatomic) IBOutlet TextFieldValidator *phno;
- (IBAction)choosefile:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *file;
@property (weak, nonatomic) IBOutlet UIButton *choosefile;
- (IBAction)updateitem:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *updatebtn;

@end
