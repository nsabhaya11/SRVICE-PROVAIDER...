//
//  images-update.m
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "images-update.h"
#import "images.h"


@interface images_update ()
{
    
    NSData* imgdata;
}

@end

@implementation images_update

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
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
 
    NSString *imgstr=[dif valueForKey:@"imgstr"];
    

    
    NSString *ss =@"http://localhost/tifflunbox/";
    NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
    
    [finalstr appendString:imgstr];
    
    NSURL *url1 =[NSURL URLWithString:finalstr];
    
    NSData *dt1 =[NSData dataWithContentsOfURL:url1];
    
    
    
    _img.image = [UIImage imageWithData:dt1];
    
    
    
    

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
    // Dispose of any resources that can be recreated.
}



- (IBAction)submit:(id)sender {
    
    UIImage * someImage = _img.image;
    imgdata = UIImageJPEGRepresentation(someImage, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    NSUserDefaults *dif =[NSUserDefaults standardUserDefaults];
    NSString *spid =[ dif valueForKey:@"spid"];
    NSString *imgid=[dif valueForKey:@"imgid"];
    NSLog(@"%@",spid);
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/updat_images.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&img_id=%@&images=%@",spid,imgid,base64];
    
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
    
    images*i1=[self.storyboard instantiateViewControllerWithIdentifier:@"img3"];
    
    [self.navigationController pushViewController:i1 animated:NO];
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
