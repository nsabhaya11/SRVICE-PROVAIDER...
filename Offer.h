//
//  Offer.h
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Offer : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)back:(id)sender;
- (IBAction)additem:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblview;

@end
