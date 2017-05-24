//
//  item.h
//  servicesprovaider
//
//  Created by MACOS on 1/9/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface item : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

{
    NSMutableArray *itemimg_arr;
    NSMutableArray *itemname_arr;
    NSMutableArray *itemprice_arr;
    
}

@property (strong, nonatomic) IBOutlet UITableView *tbl;

- (IBAction)back:(id)sender;




@end
