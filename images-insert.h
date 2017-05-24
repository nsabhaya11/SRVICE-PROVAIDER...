//
//  images-insert.h
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface images_insert : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submit;
- (IBAction)back:(id)sender;

@end
