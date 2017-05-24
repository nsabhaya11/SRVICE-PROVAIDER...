//
//  menu-cell.h
//  servicesprovaider
//
//  Created by Admin on 18/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menu_cell : UITableViewCell
    {
        UIView * view;
    }
    
    @property (weak, nonatomic) IBOutlet UILabel *itemname;
    @property (weak, nonatomic) IBOutlet UILabel *itemprice;
    @property (weak, nonatomic) IBOutlet UIImageView *itemimg;
    @property (weak, nonatomic) IBOutlet UIButton *updatebtn;

@property (strong, nonatomic) IBOutlet UISegmentedControl *staper;
   
@property (weak, nonatomic) IBOutlet UILabel *viewlbl;

@end
