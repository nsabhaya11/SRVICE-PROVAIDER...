//
//  firstpage.m
//  servicesprovaider
//
//  Created by MACOS on 12/24/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "firstpage.h"
#import "homepage.h"
#import "secondpage.h"
#import "itemtype.h"
#import "fourthpage.h"
#import "Offer.h"
#import "images.h"
#import "ViewController.h"
#import "select_detail.h"
#import "Curentorder.h"


@interface firstpage ()
{
    UIView *view;
    NSArray *arr;
    int flag;
    UIButton * btn;
    UIButton * btn1;
    UIButton * btn2;
    UIButton * btn3;
    
        UIImage *image1;
        UIImage *image2;
        UIImage *image3;
        UIImage *image4;
        UIImage *image5;
        UIImage *image6;
        UIImage *image7;
    

        
    

    
    
}

@end

@implementation firstpage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //menuview
    view = [[UIView alloc] initWithFrame:CGRectMake(0-(self.view.frame.size.width-110), 50,self.view.frame.size.width-110 , self.view.frame.size.height/2)];
    view.backgroundColor = [UIColor whiteColor];
    
    view.layer.shadowOpacity = 1;
    [self.view addSubview:view];

    

    flag = 0;
  
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    NSString *spemail=[dif valueForKey:@"spemail"];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/sssss.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_email=%@",spemail];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
    
    [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    
                                    NSArray *arr1=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                    
                                    NSLog(@"%@",[arr1 description]);
                                    
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^
                                                   {
                                                       
                                                       
                                                       
                                                       for (NSDictionary *dic3 in arr1) {
                                                           
                                                           NSString  *str=[dic3 valueForKey:@"sp_id"];
                                                           
                                                           NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
                                                           [dif setObject:str forKey:@"spid"];
     
                                                           
                                                           
                                                       }
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                   });
                                    
                                    
                                }];
    
    
    [task resume];
    
}






    
    





- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)menubtn:(id)sender {
    
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(25, 110, 60, 60)];
    
    vv.layer.cornerRadius = 30;
    
    vv.layer.borderWidth = 2;
    
    
    
    //vv.layer.cornerRadius=btnupload.frame.size.height/2;
    
    vv.clipsToBounds=YES;
    
   UIImageView* imageupload = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [imageupload setImage:[UIImage imageNamed:@"camera-128 (2).png"]];

    
    UIImageView* image = [[UIImageView alloc]initWithFrame:CGRectMake(50, 80, 120, 120)];
    
    [image setImage:[UIImage imageNamed:@"nik.jpg"]];
    
    image.layer.borderWidth = 2;
    
    image.layer.cornerRadius=image.frame.size.height/2;
    
    image.clipsToBounds=YES;
    
    //home
    
    UIButton* homebtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, 160, 50)];
    
    [homebtn setTitle:@"HOME" forState:UIControlStateNormal];
    
    [homebtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [homebtn addTarget:self action:@selector(homepage:) forControlEvents:UIControlEventTouchUpInside];
    
    homebtn.backgroundColor = [UIColor clearColor];
    
    //profile
    
    UIButton* profilebtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 230, 160, 50)];
    
    [profilebtn setTitle:@"PROFILE" forState:UIControlStateNormal];
    
    [profilebtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [profilebtn addTarget:self action:@selector(profile:) forControlEvents:UIControlEventTouchUpInside];
    
    profilebtn.backgroundColor = [UIColor clearColor];
    
    //items
    
    UIButton* itembtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 260, 160, 50)];
    
    [itembtn setTitle:@"ITEM" forState:UIControlStateNormal];
    
    [itembtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [itembtn addTarget:self action:@selector(itempage:) forControlEvents:UIControlEventTouchUpInside];
    
    itembtn.backgroundColor = [UIColor clearColor];
    
    //my menu
    
    UIButton* menubtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 290, 160, 50)];
    
    [menubtn setTitle:@"MY MENU" forState:UIControlStateNormal];
    
    [menubtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [menubtn addTarget:self action:@selector(menupage:) forControlEvents:UIControlEventTouchUpInside];
    
    menubtn.backgroundColor = [UIColor clearColor];
    
    //offer
    
    UIButton* offerbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 320, 160, 50)];
    
    [offerbtn setTitle:@"OFFERS" forState:UIControlStateNormal];
    
    [offerbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [offerbtn addTarget:self action:@selector(offerpage:) forControlEvents:UIControlEventTouchUpInside];
    
    offerbtn.backgroundColor = [UIColor clearColor];
    
    //my orders
    
    UIButton* orderbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 350, 160, 50)];
    
    [orderbtn setTitle:@"MY ORDER" forState:UIControlStateNormal];
    
    [orderbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [orderbtn addTarget:self action:@selector(orderpage:) forControlEvents:UIControlEventTouchUpInside];
    
    orderbtn.backgroundColor = [UIColor clearColor];
    
    //Images
    
    UIButton* imagesbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 380, 160, 50)];
    
    [imagesbtn setTitle:@"MY PHOTOS" forState:UIControlStateNormal];
    
    [imagesbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [imagesbtn addTarget:self action:@selector(imagespage:) forControlEvents:UIControlEventTouchUpInside];
    
    imagesbtn.backgroundColor = [UIColor clearColor];
    //logout
    
    UIButton *logoutbtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 410, 160, 50)];
    
    [logoutbtn setTitle:@"LOGOUT" forState:UIControlStateNormal];
    
    [logoutbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [logoutbtn addTarget:self action:@selector(logoutset:) forControlEvents:UIControlEventTouchUpInside];
    
    logoutbtn.backgroundColor = [UIColor clearColor];
    
    [view addSubview:logoutbtn];
    
    [view addSubview:homebtn];
    
    [view addSubview:profilebtn];
    
    [view addSubview:itembtn];
    
    [view addSubview:menubtn];
    
    [view addSubview:orderbtn];
    
    [view addSubview:imagesbtn];
    
    [view addSubview:offerbtn];
    
    
    [view addSubview:image];
    
    [view addSubview:vv];
    
    [vv addSubview:imageupload];
    


    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Blurred-Blue-and-White.jpg"]];
    if (flag == 0)
    {
        
        
        [UIView beginAnimations:NULL context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        
        view.frame = CGRectMake(0, 50,self.view.frame.size.width-110 , self.view.frame.size.height);
        
        [UIView commitAnimations];
        
        flag=1;
        
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        // add this new view to your main view
        [self.view addSubview:view];
        
        
    }else if (flag==1)
        
    {
        [UIView beginAnimations:NULL context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        
        view.frame = CGRectMake(0-(self.view.frame.size.width-110), 50,self.view.frame.size.width-110 , self.view.frame.size.height);
        
        [UIView commitAnimations];
        
        flag=0;
        
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        // add this new view to your main view
        [self.view addSubview:view];
        
        
    }
    
    
    

}
-(void)homepage:(UIButton *)sender
{
    firstpage*s1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:s1 animated:NO];
}

-(void)profile:(UIButton *)sender
{
    select_detail*p1=[self.storyboard instantiateViewControllerWithIdentifier:@"s_detail"];
    
    [self.navigationController pushViewController:p1 animated:NO];
}

-(void)itempage:(UIButton *)sender
{
    secondpage *s2=[self.storyboard instantiateViewControllerWithIdentifier:@"s2"];
    
    [self.navigationController pushViewController:s2 animated:NO];
}

-(void)offerpage:(UIButton *)sender
{
    Offer *o4=[self.storyboard instantiateViewControllerWithIdentifier:@"offer1"];
    
    [self.navigationController pushViewController:o4 animated:NO];
}

-(void)menupage:(UIButton *)sender
{
    itemtype *t3=[self.storyboard instantiateViewControllerWithIdentifier:@"itemtype"];
    
    [self.navigationController pushViewController:t3 animated:NO];
}

-(void)orderpage:(UIButton *)sender
{
    fourthpage *f4=[self.storyboard instantiateViewControllerWithIdentifier:@"f4"];
    
    [self.navigationController pushViewController:f4 animated:NO];
}
-(void)imagespage:(UIButton *)sender
{
    images*i1=[self.storyboard instantiateViewControllerWithIdentifier:@"img3"];
    
    [self.navigationController pushViewController:i1 animated:NO];
}


-(void)logoutset:(UIButton *)sender
{
    UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"" message:@"Sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *btn1 = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        //delete user ID fro user Defaults
        [defaults setObject:nil forKey:@"login_status"];
        //redirect to login view
        
        ViewController *v1 = [self.storyboard instantiateViewControllerWithIdentifier:@"v1"];
        
        [self.navigationController pushViewController:v1 animated:YES];
        
        
    }];
    
    UIAlertAction *btn2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alt addAction:btn1];
    [alt addAction:btn2];
    [self presentViewController:alt animated:YES completion:nil];
}
- (IBAction)currnt:(id)sender {
    
    Curentorder*i1=[self.storyboard instantiateViewControllerWithIdentifier:@"corder"];
    
    [self.navigationController pushViewController:i1 animated:NO];
}
@end
