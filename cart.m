//
//  cart.m
//  simpale contoroles examplaes
//
//  Created by Admin on 26/03/17.
//  Copyright © 2017 Nikunj Patel. All rights reserved.
//

#import "cart.h"
#import "cartcell.h"
#import "Address.h"


@interface cart ()
{
    NSMutableArray *cart1;
    NSMutableArray *orderary;
    NSMutableArray *qtyary;
    NSString *i_name;
    NSString *i_type;
    NSString *i_price;
   
}

@end

@implementation cart

- (void)viewDidLoad {
    [super viewDidLoad];
    
    orderary =[[NSMutableArray alloc]init];
    cart1 =[[NSMutableArray alloc]init];
    i_name =[[NSString alloc]init];
    i_type =[[NSString alloc]init];
    i_price =[[NSString alloc]init];
    
    qtyary=[[NSString alloc]init];
    
    
    
    self.tbl.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    
    NSUserDefaults * cartarr =[NSUserDefaults standardUserDefaults];
    
   
    cart1 =[cartarr valueForKey:@"cartarr"];
    NSLog(@"%@",cart1);
    
    NSInteger sum =0;
    for (int i=0; i < [cart1 count]; i++) {
        
        NSMutableArray *temp =[[NSMutableArray alloc]init];
        
        temp = [cart1 objectAtIndex:i];
    
        NSInteger val = [[temp objectAtIndex: 3] integerValue];
        
        sum = sum +val;
        
        
        
        
      //  NSString *ss =  [cart1 objectAtIndex:<#(NSUInteger)#>]
        
    }
    
    
    _total_price.text = [NSString stringWithFormat:@"%ld",sum];
    
    
    
    [_tbl reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cart1 count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    cartcell *c1=[tableView dequeueReusableCellWithIdentifier:@"cartcell" forIndexPath:indexPath];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    
    temp=[cart1 objectAtIndex:indexPath.row];
    
    
    
    
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
    
    c1.itemname.text=[temp objectAtIndex:1];
    
    c1.price.text=[temp objectAtIndex:3];
    
   
    c1.tctype.text=[temp objectAtIndex:4];
    
    c1.total.text = [temp objectAtIndex:3];
    c1.quntity.text=@"1";
    
    [c1.stepper addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    c1.stepper.maximumValue = 20;
    c1.stepper.minimumValue = 1;
    
    c1.itemname.tag =400+indexPath.row;
    
    c1.stepper.tag  = indexPath.row;
    
    c1.quntity.tag = 100+indexPath.row;
    
    c1.price.tag = 200+indexPath.row;
    
    c1.total.tag = 300+indexPath.row;
  //  c1.cartbtn.tag=indexPath.row;
    
   // [c1.cartbtn addTarget:self action:@selector(myfun2:) forControlEvents:UIControlEventTouchUpInside];
    
  

    
    return c1;
    
}

-(void)add:(UIStepper*)sender
{
    UIStepper *stepper = (UIStepper *) sender;
    
    UILabel *pric = (UILabel *)[self.view viewWithTag:sender.tag
                                +200];
    
    UILabel  *qty = (UILabel *)[self.view viewWithTag:sender.tag+100];
    
    
    UILabel *total = (UILabel *)[self.view viewWithTag:sender.tag +300];
    
    
    
    
    
    qty.text = [NSString stringWithFormat:@"%0.0f", sender.value];
    
    
    total.text   = [NSString stringWithFormat:@"%ld",[pric .text integerValue] *[qty.text integerValue]];
    
    
    
    NSInteger sum =0;
    
    for (int i = 0; i<[cart1 count]; i++) {
        
        
        UILabel *total1 = (UILabel *)[self.view viewWithTag:i +300];
        
        NSInteger ss =  [total1.text integerValue];
        
        sum = sum + ss;
        
        
        
        
    }
   
    _total_price.text = [NSString stringWithFormat:@"%ld",sum];
    
    
    NSString *totalbill=_total_price.text;
    
   
    NSUserDefaults *xyz=[NSUserDefaults standardUserDefaults];
    [xyz setObject:totalbill forKey:@"totalbill"];
}


- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)place_order:(id)sender {
    
    
    orderary =[[NSMutableArray alloc]init];
    
    NSDate *dt =[NSDate date];
    
    int rangeLow = 31;
    int rangeHigh = 60;
    int randomNumber = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
    
    NSDateFormatter *frm =[[NSDateFormatter alloc]init];
    
    [frm setDateFormat:@"dd-MM-yyyy"];
    
    NSString *strdate = [frm stringFromDate:dt];
    
    [frm setDateFormat:@"HH:mm"];
    
    NSString *time = [frm stringFromDate:dt];
   
    NSUserDefaults *nsstr=[NSUserDefaults standardUserDefaults];
    NSString *useremail=[nsstr valueForKey:@"useremail"];
    NSString *spid=[nsstr valueForKey:@"spid"];
   /// NSString *useraddress=[nsstr valueForKey:@"useraddress"];

    
    
    NSMutableString *orderid = [[NSMutableString alloc]init];
    
    [orderid appendString:[NSString stringWithFormat:@"%d",randomNumber] ];
    [orderid appendString:strdate];
   // [orderid appendString:useremail];
    [orderid appendString:time];
    
    
    NSLog(@"%@",orderid);
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    
    [dif setObject:orderid forKey:@"orderid"];
   
    
    NSLog(@"%@",useremail);
    for(int i=0; i < [cart1 count]; i++)
    {
       NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
        
        NSMutableArray *tem = [[NSMutableArray alloc]init];
        
        tem=[cart1 objectAtIndex:i];
        
        
                
        
        [temp setObject:orderid  forKey:@"order_id"];
        [temp setObject:spid  forKey:@"sp_id"];
        [temp setObject:useremail  forKey:@"user_email"];
        [temp setObject:[tem objectAtIndex:0] forKey:@"item_img"];
        [temp setObject:[tem objectAtIndex:1] forKey:@"item_name"];
        [temp setObject:[tem objectAtIndex:3] forKey:@"item_price"];
        [temp setObject:[tem objectAtIndex:4] forKey:@"tc_type"];
      //  [temp setObject:useraddress forKey:@"user_address"];
        
       UILabel *qty = (UILabel *)[self.view viewWithTag:i +100];
        
        NSLog(@"%@",qty.text);
        
        [temp setObject:qty.text forKey:@"quntity"];
        
        
        [orderary addObject:temp];
        
        NSLog(@"%@",orderary);
   
    }
    [dif setObject:orderary forKey:@"orderary"];
   /*
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
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *res=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",res);
    }];
    [task resume];
    
    
    
    NSUserDefaults * cartarr =[NSUserDefaults standardUserDefaults];
     [cartarr removeObjectForKey:@"cartarr"];
    
   */
    Address *c1=[self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    
    [self.navigationController pushViewController:c1 animated:NO];
    
    



}
@end
