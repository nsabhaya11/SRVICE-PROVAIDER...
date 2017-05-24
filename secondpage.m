//
//  secondpage.m
//  servicesprovaider
//
//  Created by MACOS on 12/26/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "secondpage.h"
#import "item.h"
#import "firstpage.h"


@interface secondpage ()
{
    NSMutableArray *final;
    int *n;
    
}
@end

@implementation secondpage

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [_imgscroll.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_imgscroll.layer setBorderWidth: 2.0];
    
    self.imgscroll.layer.cornerRadius= 10;
    self.imgscroll.clipsToBounds = YES;
    
    final=[[NSMutableArray alloc]init];
    

  
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag ==11)
    {
        
        UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"Select your Items" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *gujrati=[UIAlertAction actionWithTitle:@"Gujarati" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _itemtype.text=@"Gujarati";
        }];
        
        UIAlertAction *panjabi=[UIAlertAction actionWithTitle:@"Panjabi" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _itemtype.text=@"Panjabi";
        }];
        
        UIAlertAction *Thai=[UIAlertAction actionWithTitle:@"Thai" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _itemtype.text=@"Thai";
        }];
        
        UIAlertAction *Italian=[UIAlertAction actionWithTitle:@"Italian" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _itemtype.text=@"Italian";
        }];
        
        
        [alt addAction:gujrati];
        [alt addAction:panjabi];
        [alt addAction:Thai];
        [alt addAction:Italian];
        [self presentViewController:alt animated:YES completion:nil];
       
        
        
}
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    firstpage * f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:f1 animated:YES];
}
    
- (IBAction)btn:(id)sender {
    
    NSUserDefaults *s1=[NSUserDefaults standardUserDefaults];
    [s1 setValue:_numberofitem.text forKey:@"itemcell"];
    
    NSUserDefaults *dif1 = [NSUserDefaults standardUserDefaults];
    NSString *tctype = _itemtype.text;
    [dif1 setObject:tctype forKey:@"tctype"];
    
    
    NSUserDefaults *dif =[NSUserDefaults standardUserDefaults];
    NSString *spid =[ dif valueForKey:@"spid"];
    
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/tiffin_categaries.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type1=%@",spid,_itemtype.text];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
    
    [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           
                           
                           item *i1=[self.storyboard instantiateViewControllerWithIdentifier:@"i1"];
                           
                           [self.navigationController pushViewController:i1 animated:YES];
                         
                       });
        
        
        
    }];
    
    
    [task resume];
    

    
}
@end

