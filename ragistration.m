
//
//  ragistration.m
//  servicesprovaider
//
//  Created by MACOS on 12/19/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "ragistration.h"
#import "homepage.h"


@interface ragistration ()

#define REGEX_USER_NAME @"[a-zA-Z0-9_ ]*$"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9]{3,}+\\.[A-Za-z]{2,4}"

#define REGEX_PASSWORD @"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"

        //(?=.*?[#?!@$%^&*-])

@end

@implementation ragistration

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _sp_password.secureTextEntry=YES;
    _sp_verpassword.secureTextEntry=YES;
    
    [self validate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)validate
{
    
    
    [_sp_username  addRegx:REGEX_USER_NAME withMsg:@"enter valid username"];
    
    _sp_username.presentInView=self.view;
    
    [_sp_email addRegx:REGEX_EMAIL withMsg:@"password not valid"];
    _sp_email.presentInView=self.view;
    
    [_sp_password addRegx:REGEX_PASSWORD withMsg:@"password not valid"];
    _sp_password.presentInView=self.view;
    
    [_sp_verpassword addRegx:REGEX_PASSWORD withMsg:@"password not valid"];
    _sp_verpassword.presentInView=self.view;
 
    
}


- (IBAction)ragistration:(id)sender {
    
    if(_sp_username.validate && _sp_email.validate && _sp_password.validate && _sp_verpassword.validate )
    {
        if (_sp_password.text==_sp_verpassword.text) {
           
            
            homepage*p1=[self.storyboard instantiateViewControllerWithIdentifier:@"h1"];
            
            [self.navigationController pushViewController:p1 animated:YES];
            
            
            NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/sp_ragistration_insert.php"];
            
            NSString *strbody=[NSString stringWithFormat:@"sp_username=%@&sp_email=%@&sp_password=%@",_sp_username.text,_sp_email.text,_sp_password.text];
            
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
            
            NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
            NSString *str =_sp_email.text;
            [dif setObject:str forKey:@"spemail"];
            
            [task resume];
            
            
            
        }
        else {
            
            UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"Password error" message:@"Your Password is not match" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"OK action");
                                       }];
            [alt addAction:okAction];
            
            [self presentViewController:alt animated:YES completion:nil];
            
        }
        
        
    }
    

}




@end
