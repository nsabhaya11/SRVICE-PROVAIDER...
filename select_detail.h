//
//  select_detail.h
//  servicesprovaider
//
//  Created by Admin on 30/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface select_detail : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *street;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *pincoad;
@property (weak, nonatomic) IBOutlet UILabel *phno;
- (IBAction)libtn:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)back:(id)sender;

@end
