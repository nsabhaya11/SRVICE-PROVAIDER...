//
//  images.h
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "images-cell.h"

@interface images : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addimg;

- (IBAction)addimg:(id)sender;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tbl;






@end
