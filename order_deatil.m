//
//  order_deatil.m
//  simpale contoroles examplaes
//
//  Created by Admin on 14/05/17.
//  Copyright © 2017 Nikunj Patel. All rights reserved.
//

#import "order_deatil.h"
#import "order_itemc_cell.h"
#import "payment.h"

@interface order_deatil ()
{
    NSArray *orderary;
    NSMutableArray *final1;
    NSString *order_id;
    NSString *sp_id;
    NSString *user_email;
    NSString*bill;
    NSString *streetaddress;
    NSString *city;
    NSString *state;
    NSString *pincoad;
    NSString *phno;
}
@end

@implementation order_deatil

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *nsstr=[NSUserDefaults standardUserDefaults];
    orderary=[nsstr valueForKey:@"orderary"];
    NSLog(@"%@",orderary);
    bill=[nsstr valueForKey:@"totalbill"];
    
    _totalbill.text = [NSString stringWithFormat:@"%@",bill];
    final1=[[NSMutableArray alloc]init];
    NSString*str=@",";
    
    streetaddress =  [nsstr valueForKey:@"streetaddress"];
   city= [nsstr valueForKey:@"city"];
   state=[nsstr valueForKey:@"state"];
   pincoad = [nsstr valueForKey:@"pincoad"];
   phno = [nsstr valueForKey:@"phno"];
    
    NSMutableString *address = [[NSMutableString alloc]init];
    [address appendString:streetaddress];
    [address appendString:str];
    [address appendString:city];
    [address appendString:str];
    [address appendString:state];
    [address appendString:str];
    [address appendString:pincoad];
    [address appendString:str];
    [address appendString:phno];
    
    
    _address.text = [NSString stringWithFormat:@"%@",address];
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       
                       
                       //   NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
                       //    NSString *spid = [[arr objectAtIndex:7]valueForKey:@"sp_id"];
                       
                       //    [dif setObject:spid forKey:@"spid"];
                       
                       
                       
                       
                       for (NSDictionary *dic3 in orderary) {
                           NSMutableArray *temp=[[NSMutableArray alloc]init];
                           
                           
                           [temp addObject:[dic3 valueForKey:@"item_img"]];
                           [temp addObject:[dic3 valueForKey:@"item_name"]];
                           [temp addObject:[dic3 valueForKey:@"item_price"]];
                           [temp addObject:[dic3 valueForKey:@"quntity"]];
                           [temp addObject:[dic3 valueForKey:@"tc_type"]];
                           
                           order_id=[dic3 valueForKey:@"order_id"];
                           sp_id=[dic3 valueForKey:@"sp_id"];
                           user_email=[dic3 valueForKey:@"user_email"];
                           
                           [final1 addObject:temp];
                           
                           
                           
                           
                       }
                       
                       
                       [_tblview reloadData];
                       
                       
                       
                       
                       
                   });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    
    order_itemc_cell*c1=[tableView dequeueReusableCellWithIdentifier:@"o_i_cell" forIndexPath:indexPath];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    
    temp=[final1 objectAtIndex:indexPath.row];
    
    
    
    
    NSString *str1=[temp objectAtIndex:0];
    
    NSString *ss =@"http://localhost/tifflunbox/";
    NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
    [finalstr appendString:str1];
    
    NSURL *url1 =[NSURL URLWithString:finalstr];
    
    NSData *dt1 =[NSData dataWithContentsOfURL:url1];
    
    
    c1.img.image = [UIImage imageWithData:dt1];
    
    c1.img.layer.cornerRadius= c1.img.frame.size.width / 12;
    c1.img.clipsToBounds = YES;
    
    c1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    
    c1.quntity.layer.cornerRadius= c1.quntity.frame.size.width / 12;
    c1.quntity.clipsToBounds = YES;
    
    c1.i_name.text=[temp objectAtIndex:1];
    
    c1.price.text=[temp objectAtIndex:2];
    
    c1.quntity.text=[temp objectAtIndex:3];
    
    c1.tc_type.text=[temp objectAtIndex:4];
    

    
    return c1;
    
}


- (IBAction)btn:(id)sender {
    
    NSDate *dt =[NSDate date];
    
    NSDateFormatter *frm =[[NSDateFormatter alloc]init];
    
    [frm setDateFormat:@"dd-MM-yyyy"];
    
    NSString *strdate = [frm stringFromDate:dt];
    
    [frm setDateFormat:@"HH:mm"];
    
    NSString *time = [frm stringFromDate:dt];

    
    NSMutableString *datetime = [[NSMutableString alloc]init];
    
    
    [datetime appendString:strdate];
    
    [datetime appendString:time];
    
    NSString * status=@"pending";
    
    
    
    NSURL *url1=[NSURL URLWithString:@"http://localhost/tifflunbox/food_order_detail.php"];
    
    NSString *strbody1=[NSString stringWithFormat:@"order_id=%@&sp_id=%@&user_email=%@&totalbill=%@&datetime=%@&status=%@&Street_address=%@&city=%@&state=%@&Pincoad=%@&phno=%@",order_id,sp_id,user_email,bill,datetime,status,streetaddress,city,state,pincoad,phno];
    
    NSMutableURLRequest *request1=[NSMutableURLRequest requestWithURL:url1];
    
    NSString *strlen=[NSString stringWithFormat:@"%ld",strbody1.length];
    
    [request1 addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
    
    [request1 setHTTPMethod:@"POST"];
    
    [request1 setHTTPBody:[strbody1 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task1=[session dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",str);
        
        
    }];
    
    
    [task1 resume];
    

    
    
    NSError *error=nil;
    
    NSData *jsondata=[NSJSONSerialization dataWithJSONObject:orderary options:kNilOptions error:&error];
    NSString *urlstring=@"http://localhost/tifflunbox/place_order.php";
    
    NSURL *url=[NSURL URLWithString:urlstring];
    
    
    
    //prepare the request
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"json" forHTTPHeaderField:@"Data-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%ld",[jsondata length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsondata];
    NSURLSession *session1=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session1 dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *res=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",res);
    }];
    [task resume];
    
    
    
    NSUserDefaults * cartarr =[NSUserDefaults standardUserDefaults];
    [cartarr removeObjectForKey:@"cartarr"];
    
    payment *otppage=[self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
    [self.navigationController pushViewController:otppage animated:YES];
    
    
    
    
    
    
    
    
    
    
}
@end
