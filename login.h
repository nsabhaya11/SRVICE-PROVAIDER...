//
//  login.h
//  servicesprovaider
//
//  Created by MACOS on 12/19/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface login : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TextFieldValidator *login_email;
@property (weak, nonatomic) IBOutlet TextFieldValidator *password;

@property (weak, nonatomic) IBOutlet UIButton *login;
- (IBAction)login:(id)sender;
- (IBAction)ragistration:(id)sender;




@end
