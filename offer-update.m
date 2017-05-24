//
//  offer-update.m
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "offer-update.h"

@interface offer_update ()
{
    NSData *imgdata;
}


#define REGEX_OFFER_NAME @"[a-zA-Z0-9_ ]*$"
#define REGEX_OFFER_DETAIL @"[a-zA-Z0-9_ ]*$"
#define REGEX_OFFER_OLD_PRICE @"[0-9]{1,5}"
#define REGEX_OFFER_NEW_PRICE @"[0-9]{1,5}"
@end

@implementation offer_update

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

    
    
    
    
    
    NSUserDefaults *sp = [NSUserDefaults standardUserDefaults];
    NSString *offerid=[sp valueForKey:@"offerid"];
    NSString *spid=[sp valueForKey:@"spid"];

 
    

    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select_sp_offer_update.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&offer_id=%@",spid,offerid];
    
    
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
                                                           
                                                           
                                                           NSString *str1=[dic3 valueForKey:@"offer_img"];
                                                           
                                                           NSString *ss =@"http://localhost/tifflunbox/";
                                                           NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
                                                           
                                                           [finalstr appendString:str1];
                                                           
                                                           NSURL *url1 =[NSURL URLWithString:finalstr];
                                                           
                                                           NSData *dt1 =[NSData dataWithContentsOfURL:url1];
                                                           
                                                           
                                                           
                                                           _img.image = [UIImage imageWithData:dt1];
                                                           
                                                        
                                                           _offer_name.text=[dic3 valueForKey:@"offer_name"];
                                                           _offer_detail.text=[dic3 valueForKey:@"offer_detail"];
                                                           _old_price.text=[dic3 valueForKey:@"old_price"];
                                                           _n_price.text=[dic3 valueForKey:@"new_price"];
                                                           
                                                           
                                                   
                                                           
                                                           
                                                           
                                                           
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
    
    
    [_offer_name  addRegx:REGEX_OFFER_NAME withMsg:@"Enter valid offer titel"];
    
    _offer_name.presentInView=self.view;
    
    [_offer_detail addRegx:REGEX_OFFER_DETAIL withMsg:@"Enter valid offer detail"];
    _offer_detail.presentInView=self.view;
    
    [_old_price addRegx:REGEX_OFFER_OLD_PRICE withMsg:@"Enter valid price detail"];
    _old_price.presentInView=self.view;
    
    [_n_price addRegx:REGEX_OFFER_NEW_PRICE withMsg:@"Enter valid price detail"];
    _n_price.presentInView=self.view;
    
    
    
}




- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)upadte:(id)sender {
    
    UIImage * someImage = _img.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    NSUserDefaults *sp = [NSUserDefaults standardUserDefaults];
    NSString *offerid=[sp valueForKey:@"offerid"];
    NSString *spid=[sp valueForKey:@"spid"];
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/update-offer.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&offer_id=%@&offer_img=%@&offer_name=%@&offer_detail=%@&old_price=%@&new_price=%@",spid,offerid,base64,_offer_name.text,_offer_detail.text,_old_price.text,_n_price.text];
    
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

@end
