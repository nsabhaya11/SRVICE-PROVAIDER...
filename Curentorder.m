//
//  Curentorder.m
//  servicesprovaider
//
//  Created by Admin on 14/05/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "Curentorder.h"
#import "current_order_detail.h"
#import "ordercell.h"

@interface Curentorder ()
{
    NSMutableArray *final1;
    NSString *str;
    
}

@end

@implementation Curentorder

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblview.allowsMultipleSelectionDuringEditing = NO;
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    
    str=@"pending";
    
    NSString *spid=[dif valueForKey:@"spid"];
    
    final1=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select_order.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&status=%@",spid,str];
    
    
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
                                                           
                                                           
                                                           
                                                           
                                                           [temp addObject:[dic3 valueForKey:@"order_id"]];
                                                           [temp addObject:[dic3 valueForKey:@"totalbill"]];
                                                           [temp addObject:[dic3 valueForKey:@"user_email"]];
                                                           [temp addObject:[dic3 valueForKey:@"Street_address"]];
                                                           [temp addObject:[dic3 valueForKey:@"city"]];
                                                           [temp addObject:[dic3 valueForKey:@"state"]];
                                                           [temp addObject:[dic3 valueForKey:@"Pincoad"]];
                                                           [temp addObject:[dic3 valueForKey:@"phno"]];
                                                           [temp addObject:[dic3 valueForKey:@"datetime"]];
                                                           
                                                           
                                                           [final1 addObject:temp];
                                                           
                                                           
                                                           
                                                           
                                                       }
                                                       
                                                       [_tblview reloadData];
                                                       
                                                       
                                                       
                                                       
                                                       
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
    
    
    
    
    ordercell *c1=[tableView dequeueReusableCellWithIdentifier:@"order_cell"];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    
    
    
    
    c1.order_id.text=[temp objectAtIndex:0];
    c1.status.text=str;
    c1.total_bill.text=[temp objectAtIndex:1];
    c1.date.text=[temp objectAtIndex:8];
    
    
    
    
    
    
    return c1;
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    NSString *orderid=[temp objectAtIndex:0];
    
    NSUserDefaults*nsstr=[NSUserDefaults standardUserDefaults];
    [nsstr setObject:orderid forKey:@"orderid1"];
    NSLog(@"%@",[nsstr valueForKey:@"orderid1" ] );
    
    [nsstr setObject:temp forKey:@"orderdetail"];
    NSLog(@"%@",[nsstr valueForKey:@"orderdetail"] );
    
    
    
    current_order_detail *t3=[self.storyboard instantiateViewControllerWithIdentifier:@"corderdetail"];
    [self.navigationController pushViewController:t3 animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

@end
