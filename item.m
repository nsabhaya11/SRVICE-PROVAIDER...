//
//  item.m
//  servicesprovaider
//
//  Created by MACOS on 1/9/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "item.h"
#import "cell.h"
#import "secondpage.h"
#import "FTIndicator.h"
#import "base64.h"

@interface item ()
{
    NSMutableArray * final1;
    NSMutableArray * final2;
   
    
    int * flag;
    
    NSInteger n1;
    
    NSData *imgdata;
        
    
}
@end

@implementation item

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults * s1=[NSUserDefaults standardUserDefaults];
    n1 = [s1 integerForKey:@"itemcell"];
    
    UIImage *img1 =[UIImage imageNamed:@"hotel.png"];
    
    final1= [[NSMutableArray alloc]init] ;
    
    
    itemimg_arr =[[NSMutableArray alloc]init];
    itemname_arr =[[NSMutableArray alloc]init];
    itemprice_arr =[[NSMutableArray alloc]init];
    
    
    
    
    for (int i=0; i<n1; i++) {
        
        
        [final1 addObject:img1];
        
    
    }

    
    
    flag=0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [final1 count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell *c1=[tableView dequeueReusableCellWithIdentifier:@"mycell"forIndexPath:indexPath];
    
    //image
    
    c1.item_image.tag=indexPath.row;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(myfun1:)];
    [c1.item_image addGestureRecognizer:tap];
    
    c1.item_image.userInteractionEnabled = YES;
    
    if ([final1 count] >0) {
        
        
        c1.item_image.image = (UIImage *)[final1 objectAtIndex:indexPath.row];
        
    }
    //textfild
    
    c1.item_name.tag  = 101+indexPath.row;
    c1.item_price.tag = 201+indexPath.row;
    
    
    c1.item_name.delegate = self;
    c1.item_price.delegate = self;
   
        
    //add button
    
    c1.insertbtn.tag=indexPath.row;
    
    [c1.insertbtn addTarget:self action:@selector(myfun2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    return c1;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    NSUserDefaults * s1=[NSUserDefaults standardUserDefaults];
    n1 = [[s1 valueForKey:@"itemcell"] integerValue];
    
    
    if (100<=textField.tag && textField.tag <100+n1) {
        
        
        [itemname_arr addObject:textField.text];
        
        NSLog(@"%@",[itemname_arr description]);
        
        
    }
    else if (200<=textField.tag && textField.tag <200+n1){
        
        [itemprice_arr addObject:textField.text];
        
        NSLog(@"%@",[itemprice_arr description]);
        
    }
    
    return YES;
    
    
    
}
    
-(void)myfun1:(UITapGestureRecognizer *)sender
    {
        flag = sender.view.tag;
        
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.delegate=self;
        
        [self presentViewController:picker animated:YES completion:nil];
        
 
    }


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    UIImage *img2 = info[UIImagePickerControllerOriginalImage];
    
    [itemimg_arr addObject:img2];
  
    [final1 replaceObjectAtIndex:flag withObject:img2];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [_tbl reloadData];
    
}




-(void)myfun2:(UIButton*)sender
{
    
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    NSString *spid=[dif valueForKey:@"spid"];
    NSString *tctype=[dif valueForKey:@"tctype"];
    
    NSString *str1=[itemname_arr objectAtIndex:sender.tag];
    NSString *str2=[itemprice_arr objectAtIndex:sender.tag];
    UIImage *img1 =(UIImage *)[itemimg_arr objectAtIndex:sender.tag];
    
    // UIImage * someImage = [NSMutableArray arrayWithObject:itemimg_arr];
    imgdata = UIImageJPEGRepresentation(img1, 1.0);
    NSString *base64 = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    final2=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/item_insert.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type=%@&item_img=%@&item_name=%@&item_price=%@",spid,tctype,base64,str1,str2];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
    
    [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    
                                    // NSArray *arr=[[NSArray alloc]init];
                                    //  arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                    
                                    //   NSLog(@"%@",[arr description]);
                                    
                                    
                                    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"%@",str);
                                    
                                    
                                    
                                }];
    
    
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    
   
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
    
   // [FTIndicator showProgressWithmessage:@""];
    
    [FTIndicator showNotificationWithImage:[UIImage imageNamed:@"55335-restaurant-symbol-of-cutlery-in-a-circle.png"]
                                     title:@"TIFFLUN BOX"
                                   message:@"Save successfully"];
}


@end
