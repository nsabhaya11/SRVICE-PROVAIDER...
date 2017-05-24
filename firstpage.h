//
//  firstpage.h
//  servicesprovaider
//
//  Created by MACOS on 12/24/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstpage : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)menubtn:(id)sender;

- (IBAction)currnt:(id)sender;

@end
