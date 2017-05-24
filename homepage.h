//
//  homepage.h
//  servicesprovaider
//
//  Created by MACOS on 12/19/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface homepage : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

- (IBAction)update:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *main_image;
@property (strong, nonatomic) IBOutlet TextFieldValidator *name;
    @property (strong, nonatomic) IBOutlet TextFieldValidator *address;
    @property (strong, nonatomic) IBOutlet TextFieldValidator *street;
    @property (strong, nonatomic) IBOutlet TextFieldValidator *city;
    @property (strong, nonatomic) IBOutlet TextFieldValidator *pincoad;
    @property (strong, nonatomic) IBOutlet TextFieldValidator *phonno;

@property (strong, nonatomic) IBOutlet UITextField *doc;
@property (strong, nonatomic) IBOutlet UIButton *file_btn;

- (IBAction)file_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *prsentview;


- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submit;
- (IBAction)back:(id)sender;

@end
