//
//  fourthpage.m
//  servicesprovaider
//
//  Created by MACOS on 12/26/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "fourthpage.h"
#import "firstpage.h"
#import "ordercell.h"
#import "order_item_vc.h"
#import "current_order_detail.h"
@interface fourthpage ()
    {
        NSMutableArray *final1;
        NSString *str1;
    }

@end

@implementation fourthpage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tbl.allowsMultipleSelectionDuringEditing = NO;
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    
    str1=@"On The way";
    
    NSString *spid=[dif valueForKey:@"spid"];
    
    final1=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select_order.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&status=%@",spid,str1];
    
    
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
    
    
    
    
    ordercell *c1=[tableView dequeueReusableCellWithIdentifier:@"order_cell"];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    
    
    
    
    c1.order_id.text=[temp objectAtIndex:0];
    c1.status.text=str1;
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
    [nsstr setObject:orderid forKey:@"orderid2"];
    NSLog(@"%@",[nsstr valueForKey:@"orderid2" ] );
    
    [nsstr setObject:temp forKey:@"orderdetail"];
    NSLog(@"%@",[nsstr valueForKey:@"orderdetail"] );
    
    
    
    order_item_vc*t3=[self.storyboard instantiateViewControllerWithIdentifier:@"o_item"];
    [self.navigationController pushViewController:t3 animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    }


- (IBAction)back:(id)sender {
    firstpage*s1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:s1 animated:NO];
}
@end
