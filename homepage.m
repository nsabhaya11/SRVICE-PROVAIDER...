//
//  homepage.m
//  servicesprovaider
//
//  Created by MACOS on 12/19/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "homepage.h"
#import "firstpage.h"
#import "upate1.h"
#import "base64.h"
#import "foodlisence.h"

@interface homepage ()
#define REGEX_USER_NAME_LIMIT @"^.{3,20}$"
#define REGEX_USER_NAME @"[a-zA-Z0-9_ ]*$"
#define REGEX_USER_ADDRESS @"^[a-zA-Z0-9_ ]*$"
#define REGEX_USER_STREET @"[A-Za-z0-9]{3,20}"
#define REGEX_USER_CITY @"[A-Za-z]{3,20}"
#define REGEX_USER_PINCOAD @"[0-9]{6,10}"
#define REGEX_USER_PHONNO @"[0-9]{10}"

{
    NSData *imgdata;
    NSMutableArray *temp;
    
}

@end

@implementation homepage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_main_image.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_main_image.layer setBorderWidth: 2.0];
    
   
    self.main_image.layer.cornerRadius= 10;
    self.main_image.clipsToBounds = YES;
    
    
    
    self.file_btn.layer.cornerRadius= 10;
    self.file_btn.clipsToBounds = YES;
    
    
    
  
    
    self.submit.layer.cornerRadius= 10;
    self.submit.clipsToBounds = YES;
    
    
        
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfun1)];
        _main_image.userInteractionEnabled=YES;
        tap.numberOfTapsRequired=1;
        [_main_image addGestureRecognizer:tap];
    
    
    
   
    //_prsentview = self.view;
    
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
        _main_image.image=info[UIImagePickerControllerOriginalImage];
    
    
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
        
        [_phonno addRegx:REGEX_USER_PHONNO withMsg:@"enter valid phoneno"];
        _phonno.presentInView=self.view;
        
        
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)file_btn:(id)sender {
}

- (IBAction)submit:(id)sender {
    
if(_name.validate && _address.validate && _street.validate && _city.validate && _pincoad.validate && _phonno.validate)
    {
    UIImage * someImage = _main_image.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    
        NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
        NSString *spemail=[dif valueForKey:@"spemail"];

    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/insert_sp.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_email=%@&main_img=%@&form_name=%@&form_address=%@&form_phoneno=%@&street=%@&city=%@",spemail,base64,_name.text,_address.text,_phonno.text,_street.text,_city.text];
    
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
    
        firstpage *f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
        [self.navigationController pushViewController:f1 animated:YES];
    
    
    
    }
    
    
    
}
- (IBAction)choosefile_btn:(id)sender {
    
   foodlisence *f1=[self.storyboard instantiateViewControllerWithIdentifier:@"food"];
    
    [self.navigationController pushViewController:f1 animated:YES];
    
}
- (IBAction)update:(id)sender {
    
    upate1 *u1=[self.storyboard instantiateViewControllerWithIdentifier:@"u1"];
    
    [self.navigationController pushViewController:u1 animated:YES];
}
- (IBAction)back:(id)sender {
    
    firstpage *f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:f1 animated:NO];
    
  //  [self.navigationController popViewControllerAnimated:YES];
}

@end
