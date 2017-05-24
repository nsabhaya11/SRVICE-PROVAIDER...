//
//  login.m
//  servicesprovaider
//
//  Created by MACOS on 12/19/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "login.h"
#import "firstpage.h"
#import "ragistration.h"

@interface login ()
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9]{3,}+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
@end

        //(?=.*?[#?!@$%^&*-])

@implementation login


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _password.secureTextEntry=YES;
    [self validate];
    
}
-(void)validate
{
    
    [_login_email  addRegx:REGEX_EMAIL withMsg:@"enter valid username"];
    
    _login_email.presentInView=self.view;
    [_password addRegx:REGEX_PASSWORD withMsg:@"password not valid"];
    _password.presentInView=self.view;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    
    if(_login_email.validate && _password.validate)
    {
        
        
        // NSLog(@"all data is write");
        
        
        
        NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/sp_login_select.php"];
        
        NSString *strbody=[NSString stringWithFormat:@"sp_email=%@&sp_password=%@",_login_email.text,_password.text];
        
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        
        NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
        
        [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSession *session=[NSURLSession sharedSession];
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    {
                                        
                                        
                                        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                        
                                        NSLog(@"%@",[arr description]);
                                        
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^
                                                       {
                                                           
                                                           
                                                           if([arr count]==1)
                                                           {
                                                               
                                                               NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
                                                               NSString *spid = [[arr objectAtIndex:0]valueForKey:@"sp_id"];
                                                               
                                                               
                                                               
                                                               NSString *str =_login_email.text;
                                                               [dif setObject:str forKey:@"spemail"];
                                                               
                                                               [dif setObject:spid forKey:@"spid"];
                                                               
                                                               [dif setObject:@"1" forKey:@"login_status"];
                                                               
                                                               
                                                               firstpage *f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
                                                               [self.navigationController pushViewController:f1 animated:YES];
                                                               
                                                               
                                                               
                                                               
                                                           }
                                                           else
                                                           {
                                                               
                                                               
                                                               
                                                               UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"Login error" message:@"Your Login detail is not match" preferredStyle:UIAlertControllerStyleAlert];
                                                               
                                                               UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                                                                                                  style:UIAlertActionStyleDefault
                                                                                                                handler:^(UIAlertAction *action)
                                                                                          {
                                                                                              NSLog(@"OK action");
                                                                                          }];
                                                               [alt addAction:okAction];
                                                               
                                                               [self presentViewController:alt animated:YES completion:nil];
                                                               
                                                               
                                                           }
                                                           
                                                       });
                                        
                                        
                                    }];
        
        
        [task resume];
        
    }
    
    
    
    
}

- (IBAction)ragistration:(id)sender {
    ragistration*r1=[self.storyboard instantiateViewControllerWithIdentifier:@"r1"];
    [self.navigationController pushViewController:r1 animated:YES];
}



@end
