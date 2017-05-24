//
//  order_item_vc.m
//  servicesprovaider
//
//  Created by MACOS on 4/11/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "order_item_vc.h"
#import "order_itemc_cell.h"

@interface order_item_vc ()
{
    NSMutableArray*final1;
    NSString*bill;
    NSString *streetaddress;
    NSString *city;
    NSString *state;
    NSString *pincoad;
    NSString *phno;
    NSString *useremail;
}


@end

@implementation order_item_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
   
    
    NSString *spid=[dif valueForKey:@"spid"];
    NSString *orderid=[dif valueForKey:@"orderid2"];
    
    NSMutableArray *orderdetail=[dif valueForKey:@"orderdetail"];
    
    NSLog(@"%@",orderdetail);
    
    
    
    _price.text=[orderdetail objectAtIndex:1];
    
    streetaddress=[orderdetail objectAtIndex:3];
    city=[orderdetail objectAtIndex:4];
    state=[orderdetail objectAtIndex:5];
    pincoad=[orderdetail objectAtIndex:6];
    phno=[orderdetail objectAtIndex:7];
    useremail=[orderdetail objectAtIndex:2];
    NSString*str=@",";
    
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
    [address appendString:str];
    [address appendString:useremail];
    
    
    _address.text = [NSString stringWithFormat:@"%@",address];
    
    
    
    
    

    
    final1=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select_order_item.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&order_id=%@",spid,orderid];
    
    
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
                                                           
                                                           
                                                           
                                                           
                                                           [temp addObject:[dic3 valueForKey:@"item_name"]];
                                                           [temp addObject:[dic3 valueForKey:@"tc_type"]];
                                                           [temp addObject:[dic3 valueForKey:@"item_price"]];
                                                           [temp addObject:[dic3 valueForKey:@"quntity"]];
                                                           [temp addObject:[dic3 valueForKey:@"item_img"]];
                                                           
                                                           [final1 addObject:temp];
                                                           
                                                           
                                                           
                                                           
                                                       }
                                                       
                                                       [_tbl reloadData];
                                                       
                                                       
                                                       
                                                       
                                                       
                                                   });
                                    
                                    
                                }];
    
    
    [task resume];
    
    
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
    
    
    
    
    order_itemc_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"o_i_cell"];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    NSString *str = [temp objectAtIndex:4];
    
    NSString *ss =@"http://localhost/tifflunbox/";
    
    NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
    
    [finalstr appendString:str];
    
    NSURL *url1 =[NSURL URLWithString:finalstr];
    
    NSData *dt1 =[NSData dataWithContentsOfURL:url1];
    
    
    
    
    
    
    c1.img.image = [UIImage imageWithData:dt1];
    
  
    
    
    
    c1.i_name.text=[temp objectAtIndex:0];
    c1.tc_type.text=[temp objectAtIndex:1];
    c1.price.text=[temp objectAtIndex:2];
    c1.quntity.text=[temp objectAtIndex:3];
    
    
    
    return c1;
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

    
}

@end
