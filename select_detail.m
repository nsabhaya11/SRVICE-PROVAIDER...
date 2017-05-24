
//
//  select_detail.m
//  servicesprovaider
//
//  Created by Admin on 30/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "select_detail.h"
#import "upate1.h"


@interface select_detail ()

@end

@implementation select_detail

- (void)viewDidLoad {
    [super viewDidLoad];
    [_img.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_img.layer setBorderWidth: 2.0];
    
    
    self.img.layer.cornerRadius= 10;
    self.img.clipsToBounds = YES;
    

    
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    NSString *spid=[dif valueForKey:@"spid"];
    
   
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select_sp_profile.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@",spid];
    
    
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
                                                           
                                                           
                                                           NSString  *str=[dic3 valueForKey:@"main_img"];
                                                           
                                                           NSString *ss =@"http://localhost/tifflunbox/";
                                                           NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
                                                           [finalstr appendString:str];
                                                           
                                                           NSURL *url1 =[NSURL URLWithString:finalstr];
                                                           
                                                           NSData *dt1 =[NSData dataWithContentsOfURL:url1];
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           _img.image = [UIImage imageWithData:dt1];
                                                           
                                                           
                                                           
                                                           
                                                           _name.text=[dic3 valueForKey:@"form_name"];
                                                           _address.text=[dic3 valueForKey:@"form_address"];
                                                           _phno.text=[dic3 valueForKey:@"form_phoneno"];
                                                           _street.text=[dic3 valueForKey:@"street"];
                                                           _city.text=[dic3 valueForKey:@"city"];
                                                           _pincoad.text=[dic3 valueForKey:@"pincoad"];
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                       }
                                                       
                                                       
                                                       
                                                       
                                                       
                                                   });
                                    
                                    
                                }];
    
    
    [task resume];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)libtn:(id)sender {
    
}

- (IBAction)update:(id)sender {
    
    upate1*r1=[self.storyboard instantiateViewControllerWithIdentifier:@"u1"];
    [self.navigationController pushViewController:r1 animated:YES];
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
