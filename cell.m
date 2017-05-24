//
//  cell.m
//  servicesprovaider
//
//  Created by Admin on 09/01/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "cell.h"

@implementation cell
@synthesize item_image;
@synthesize item_name;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [item_image.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [item_image.layer setBorderWidth: 2.0];
    
    [_cell1.layer setBorderColor: [[UIColor blackColor] CGColor]];
   [_cell1.layer setBorderWidth: 2.0];
    
    self.item_image.layer.cornerRadius= 10;
    self.item_image.clipsToBounds = YES;
    
    self.cell1.layer.cornerRadius= 10;
    self.cell1.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfun1)];
    item_image.userInteractionEnabled=YES;
    tap.numberOfTapsRequired=1;
    [item_image addGestureRecognizer:tap];
   

}
-(void)myfun1
{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate=self;
    
 // [self presentViewController:picker animated:YES completion:nil];
    
   


}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    

}




//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
//}





- (IBAction)insert_item:(id)sender {
}
- (IBAction)insertbtn:(id)sender {
}
@end
