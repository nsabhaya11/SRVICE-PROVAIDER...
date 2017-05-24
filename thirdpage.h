//
//  thirdpage.h
//  servicesprovaider
//
//  Created by MACOS on 12/26/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface thirdpage : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
- (IBAction)back:(id)sender;
    @property (weak, nonatomic) IBOutlet UITableView *tblview;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *additem;
- (IBAction)additem:(id)sender;

@end
