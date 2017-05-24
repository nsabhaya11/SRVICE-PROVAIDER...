//
//  itemtype.h
//  servicesprovaider
//
//  Created by Admin on 19/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemtype : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)additem:(id)sender;
    @property (weak, nonatomic) IBOutlet UITableView *tbl;
- (IBAction)back:(id)sender;



@end
