//
//  secondpage.h
//  servicesprovaider
//
//  Created by MACOS on 12/26/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondpage : UIViewController<UITextFieldDelegate>
{
    NSString *str1;
}

@property (strong, nonatomic) IBOutlet UITextField *itemtype;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UITextField *numberofitem;


@property (strong, nonatomic) IBOutlet UIImageView *imgscroll;

- (IBAction)back:(id)sender;
- (IBAction)btn:(id)sender;


@end
