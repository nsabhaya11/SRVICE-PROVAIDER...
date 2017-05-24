//
//  item-update.m
//  servicesprovaider
//
//  Created by Admin on 07/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "item-update.h"
#import "itemtype.h"

@interface item_update ()

#define REGEX_ITEM_TYPE @"[A-Za-z]{2,20}"
#define REGEX_ITEM_NAME @"[a-zA-Z0-9_ ]*$}"
#define REGEX_ITEM_DETAIL @"[a-zA-Z0-9_ ]*$"
#define REGEX_ITEM_PRICE @"[0-9]{1,5}"
{
    NSData *imgdata;
}

@end

@implementation item_update

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_img.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_img.layer setBorderWidth: 2.0];
    
    
    self.img.layer.cornerRadius= 10;
    self.img.clipsToBounds = YES;
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfun1)];
    _img.userInteractionEnabled=YES;
    tap.numberOfTapsRequired=1;
    [_img addGestureRecognizer:tap];
    
    [self validate];
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    NSString *itemid=[dif valueForKey:@"itemid"];
    NSLog(@"%@",itemid);
    
    NSUserDefaults *sp = [NSUserDefaults standardUserDefaults];
    NSString *tctype=[sp valueForKey:@"tctype"];
    NSString *spid=[dif valueForKey:@"spid"];
    
 
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/u_select_item.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type=%@&item_id=%@",spid,tctype,itemid];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
    
    [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    
                                    NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                    
                                    NSLog(@"%@",[arr description]);
                                    
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^
                                                   {
                                                       
                                                       
                                                       
                                                       for (NSDictionary *dic3 in arr) {
                                                           
                                                           
                                                           NSString  *str=[dic3 valueForKey:@"item_img"];
                                                           
                                                           NSString *ss =@"http://localhost/tifflunbox/";
                                                           NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
                                                           [finalstr appendString:str];
                                                           
                                                           NSURL *url1 =[NSURL URLWithString:finalstr];
                                                           
                                                           NSData *dt1 =[NSData dataWithContentsOfURL:url1];
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           _img.image = [UIImage imageWithData:dt1];
                                                           
                                                           
                                                           _item_type.text=tctype;
                                                           _item_name.text=[dic3 valueForKey:@"item_name"];
                                                           _item_detail.text=[dic3 valueForKey:@"item_detail"];
                                                           _item_pric.text=[dic3 valueForKey:@"item_price"];
                                                           
                                                           
                                                           
                                                           
                                                       }
                                                       
                                                      
                                                       
                                                       
                                                       
                                                       
                                                   });
                                    
                                    
                                }];
    
    
    [task resume];
    
    
    
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
    _img.image=info[UIImagePickerControllerOriginalImage];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)validate
{
    
    

    
    [_item_name addRegx:REGEX_ITEM_NAME withMsg:@"Enter valid item name"];
    _item_name.presentInView=self.view;
    
    [_item_detail addRegx:REGEX_ITEM_DETAIL withMsg:@"Enter valid item detail"];
    _item_detail.presentInView=self.view;
    
    [_item_pric addRegx:REGEX_ITEM_PRICE withMsg:@"Enter valid item price"];
    _item_pric.presentInView=self.view;
    
    
    
    
}



- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)update_item:(id)sender {
    
    if( _item_name.validate && _item_detail.validate && _item_pric.validate)
    {
        
        
        
    
    UIImage * someImage = _img.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSUserDefaults *di = [NSUserDefaults standardUserDefaults];
    NSString *itemid=[di valueForKey:@"itemid"];
    NSLog(@"%@",itemid);
    
    NSUserDefaults *dif =[NSUserDefaults standardUserDefaults];
    NSString *spid =[ dif valueForKey:@"spid"];
    NSString *tctype=[dif valueForKey:@"tctype"];
    NSLog(@"%@",spid);
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/update-item.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"item_id=%@&sp_id=%@&tc_type=%@&item_img=%@&item_name=%@&item_detail=%@&item_price=%@",itemid,spid,tctype,base64,_item_name.text,_item_detail.text,_item_pric.text];
    
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
        [self.navigationController pushViewController:t3 animated:NO];
   
}

}

@end
