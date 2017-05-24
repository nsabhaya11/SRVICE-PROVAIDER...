//
//  offer-insert.h
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface offer_insert : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *offerimg;
    @property (weak, nonatomic) IBOutlet TextFieldValidator *offername;
    @property (weak, nonatomic) IBOutlet TextFieldValidator *offerdetal;
    @property (weak, nonatomic) IBOutlet TextFieldValidator *oldprice;
    @property (weak, nonatomic) IBOutlet TextFieldValidator *newprice;

- (IBAction)submit:(id)sender;

@end
