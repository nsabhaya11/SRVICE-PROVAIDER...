//
//  ragistration.h
//  servicesprovaider
//
//  Created by MACOS on 12/19/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface ragistration : UIViewController<UINavigationControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TextFieldValidator *sp_username;
@property (weak, nonatomic) IBOutlet TextFieldValidator *sp_email;
@property (weak, nonatomic) IBOutlet TextFieldValidator *sp_password;
@property (weak, nonatomic) IBOutlet TextFieldValidator *sp_verpassword;

- (IBAction)ragistration:(id)sender;



@end
