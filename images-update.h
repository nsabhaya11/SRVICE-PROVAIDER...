//
//  images-update.h
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface images_update : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
- (IBAction)submit:(id)sender;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end
