//
//  fourthpage.h
//  servicesprovaider
//
//  Created by MACOS on 12/26/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fourthpage : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)back:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tbl;


@end
