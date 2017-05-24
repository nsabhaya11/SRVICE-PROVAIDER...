//
//  upate1.m
//  servicesprovaider
//
//  Created by MACOS on 12/28/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "upate1.h"
#import "homepage.h"
#import "firstpage.h"

@interface upate1 ()
{
    NSMutableArray *final;
    NSData *imgdata;
}
#define REGEX_USER_NAME_LIMIT @"^.{3,20}$"
#define REGEX_USER_NAME @"[a-zA-Z0-9_ ]*$"
#define REGEX_USER_ADDRESS @"^[a-zA-Z0-9_ ]*$"
#define REGEX_USER_STREET @"[A-Za-z0-9]{3,20}"
#define REGEX_USER_CITY @"[A-Za-z]{3,20}"
#define REGEX_USER_PINCOAD @"[0-9]{3,10}"
#define REGEX_USER_PHONNO @"[0-9]{10}"


@end

@implementation upate1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_img.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_img.layer setBorderWidth: 2.0];
    
    
    self.img.layer.cornerRadius= 10;
    self.img.clipsToBounds = YES;
    
  
    
    self.updatebtn.layer.cornerRadius= 10;
    self.updatebtn.clipsToBounds = YES;
    
    
    [self validate];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfun1)];
    _img.userInteractionEnabled=YES;
    tap.numberOfTapsRequired=1;
    [_img addGestureRecognizer:tap];
    
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    NSString *spid=[dif valueForKey:@"spid"];
    
    final=[[NSMutableArray alloc]init];
    
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
                                                           NSMutableArray *temp=[[NSMutableArray alloc]init];
                                                           
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
                                                        
                                                           
                                                           
                                                           [final addObject:temp];
                                                           
                                                           
                                                       }
                                                       
                                                       
                                                       
                                                       
                                                       
                                                   });
                                    
                                    
                                }];
    
    
    [task resume];
    
    
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
    
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



- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)choosefile:(id)sender {
}
- (IBAction)updateitem:(id)sender {
    
    if(_name.validate && _address.validate && _street.validate && _city.validate && _pincoad.validate && _phno.validate)
    {
    
    UIImage * someImage = _img.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
        NSString *spemail=[dif valueForKey:@"spemail"];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/insert_sp.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_email=%@&main_img=%@&form_name=%@&form_address=%@&form_phoneno=%@&street=%@&city=%@&pincoad=%@",spemail,base64,_name.text,_address.text,_phno.text,_street.text,_city.text,_pincoad.text];
    
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
        
        firstpage*s1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
        
        [self.navigationController pushViewController:s1 animated:NO];
    
    }
    
}

-(void)validate
{
    
    
    [_name  addRegx:REGEX_USER_NAME withMsg:@"enter valid name"];
    
    _name.presentInView=self.view;
    
    [_address addRegx:REGEX_USER_ADDRESS withMsg:@"Address is not valid"];
    _address.presentInView=self.view;
    
    [_street addRegx:REGEX_USER_STREET withMsg:@"enter valid street"];
    _street.presentInView=self.view;
    
    [_city addRegx:REGEX_USER_CITY withMsg:@"enter valid city"];
    _city.presentInView=self.view;
    
    [_pincoad addRegx:REGEX_USER_PINCOAD withMsg:@"enter valid pincoad"];
    _pincoad.presentInView=self.view;
    
    [_phno addRegx:REGEX_USER_PHONNO withMsg:@"enter valid phoneno"];
    _phno.presentInView=self.view;
    
    
}
- (IBAction)update_licecencepic:(id)sender {
}
@end
