//
//  foodlisence.h
//  servicesprovaider
//
//  Created by Admin on 28/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface foodlisence : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)back:(id)sender;
- (IBAction)insert:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
