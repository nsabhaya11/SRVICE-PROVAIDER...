//
//  item-insert.m
//  servicesprovaider
//
//  Created by Admin on 19/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "item-insert.h"
#import "thirdpage.h"
#import "itemtype.h"

@interface item_insert ()
    {
        NSData * imgdata;
    }


#define REGEX_ITEM_TYPE @"[A-Za-z]{2,20}"
#define REGEX_ITEM_NAME @"[a-zA-Z0-9_ ]*$"
#define REGEX_ITEM_DETAIL @"[a-zA-Z0-9_ ]*$"
#define REGEX_ITEM_PRICE @"[0-9]{1,5}"



@end

@implementation item_insert

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_item_img.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_item_img.layer setBorderWidth: 2.0];
    
    
    self.item_img.layer.cornerRadius= 10;
    self.item_img.clipsToBounds = YES;
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfun1)];
    _item_img.userInteractionEnabled=YES;
    tap.numberOfTapsRequired=1;
    [_item_img addGestureRecognizer:tap];
    
    [self validate];

    
}
    
-(void)myfun1
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.delegate=self;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
    {
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        _item_img.image=info[UIImagePickerControllerOriginalImage];
        
        
    }
    
- (void)textFieldDidBeginEditing:(UITextField *)textField
    {
        if(textField.tag ==12)
        {
            
            UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"Select your Items" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *gujrati=[UIAlertAction actionWithTitle:@"Gujarati" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _item_type.text=@"Gujarati";
            }];
            
            UIAlertAction *panjabi=[UIAlertAction actionWithTitle:@"Panjabi" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _item_type.text=@"Panjabi";
            }];
            
            UIAlertAction *Thai=[UIAlertAction actionWithTitle:@"Thai" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _item_type.text=@"Thai";
            }];
            
            UIAlertAction *Italian=[UIAlertAction actionWithTitle:@"Italian" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _item_type.text=@"Italian";
            }];
            
            
            [alt addAction:gujrati];
            [alt addAction:panjabi];
            [alt addAction:Thai];
            [alt addAction:Italian];
            [self presentViewController:alt animated:YES completion:nil];
            
            
            
        }
    }
- (void)textFieldDidEndEditing:(UITextField *)textField
    {
        if(textField.tag ==12)
        {
            
        NSUserDefaults *dif =[NSUserDefaults standardUserDefaults];
        NSString *spid =[ dif valueForKey:@"spid"];
        NSLog(@"%@",spid);
        
        
        NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/tiffin_categaries.php"];
        
        NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type=%@",spid,_item_type.text];
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        
        NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
        
        [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSession *session=[NSURLSession sharedSession];
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",str);
            
            
        }];
        
        
        [task resume];
    
        }
        
    }
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
    
    


- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)insert_item:(id)sender {
    
    
    if(_item_type.validate && _item_name.validate && _item_detail.validate && _item_price.validate)
    {
    
    UIImage * someImage = _item_img.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    NSUserDefaults *dif =[NSUserDefaults standardUserDefaults];
    NSString *spid =[ dif valueForKey:@"spid"];
    NSLog(@"%@",spid);
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/item_insert.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type=%@&item_img=%@&item_name=%@&item_detail=%@&item_price=%@",spid,_item_type.text,base64,_item_name.text,_item_detail.text,_item_price.text];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
    
    [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",str);
        
        
    }];
    
    
        [task resume];
    
        itemtype *t3=[self.storyboard instantiateViewControllerWithIdentifier:@"itemtype"];
        
        [self.navigationController pushViewController:t3 animated:YES];

    }
}


-(void)validate
{
    
    
    [_item_type  addRegx:REGEX_ITEM_TYPE withMsg:@"Enter valid item type"];
    
    _item_type.presentInView=self.view;
    
    [_item_name addRegx:REGEX_ITEM_NAME withMsg:@"Enter valid item name"];
    _item_name.presentInView=self.view;
    
    [_item_detail addRegx:REGEX_ITEM_DETAIL withMsg:@"Enter valid item detail"];
    _item_detail.presentInView=self.view;
    
    [_item_price addRegx:REGEX_ITEM_PRICE withMsg:@"Enter valid item price"];
    _item_price.presentInView=self.view;
    

    
    
}
@end
