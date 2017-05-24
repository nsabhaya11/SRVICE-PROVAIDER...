//
//  offer-insert.m
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "offer-insert.h"

@interface offer_insert ()
    {
        NSData *imgdata;
    }


#define REGEX_OFFER_NAME @"[a-zA-Z0-9_ ]*$"
#define REGEX_OFFER_DETAIL @"[a-zA-Z0-9_ ]*$"
#define REGEX_OFFER_OLD_PRICE @"[0-9]{1,5}"
#define REGEX_OFFER_NEW_PRICE @"[0-9]{1,5}"

@end

@implementation offer_insert

- (void)viewDidLoad {
    [super viewDidLoad];
    [_offerimg.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_offerimg.layer setBorderWidth: 2.0];
    
    
    self.offerimg.layer.cornerRadius= 10;
    self.offerimg.clipsToBounds = YES;
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfun1)];
    _offerimg.userInteractionEnabled=YES;
    tap.numberOfTapsRequired=1;
    [_offerimg addGestureRecognizer:tap];

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
        _offerimg.image=info[UIImagePickerControllerOriginalImage];
        
        
    }
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)submit:(id)sender {
    
    UIImage * someImage = _offerimg.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    NSUserDefaults *dif =[NSUserDefaults standardUserDefaults];
    NSString *spid =[ dif valueForKey:@"spid"];
    NSLog(@"%@",spid);
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/insert-offer.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&offer_img=%@&offer_name=%@&offer_detail=%@&old_price=%@&new_price=%@",spid,base64,_offername.text,_offerdetal.text,_oldprice.text,_newprice.text];
    
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

-(void)validate
{
    
    
    [_offername  addRegx:REGEX_OFFER_NAME withMsg:@"Enter valid offer titel"];
    
    _offername.presentInView=self.view;
    
    [_offerdetal addRegx:REGEX_OFFER_DETAIL withMsg:@"Enter valid offer detail"];
    _offerdetal.presentInView=self.view;
    
    [_oldprice addRegx:REGEX_OFFER_OLD_PRICE withMsg:@"Enter valid price detail"];
    _oldprice.presentInView=self.view;
    
    [_newprice addRegx:REGEX_OFFER_NEW_PRICE withMsg:@"Enter valid price detail"];
    _newprice.presentInView=self.view;
    

    
}

@end
