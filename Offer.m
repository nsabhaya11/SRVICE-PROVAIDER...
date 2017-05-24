//
//  Offer.m
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "Offer.h"
#import "offer-insert.h"
#import "firstpage.h"
#import "offer_cell.h"
#import "offer-update.h"

@interface Offer ()

{
    NSMutableArray *final1;
}

@end

@implementation Offer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tblview.allowsMultipleSelectionDuringEditing = NO;
    
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    
    NSString *spid=[dif valueForKey:@"spid"];
    
    final1=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select-offer.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@",spid];
    
    
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
                                                           
                                                           
                                                           
                                                           [temp addObject:[dic3 valueForKey:@"offer_img"]];
                                                           [temp addObject:[dic3 valueForKey:@"offer_name"]];
                                                           [temp addObject:[dic3 valueForKey:@"offer_detail"]];
                                                           [temp addObject:[dic3 valueForKey:@"old_price"]];
                                                           [temp addObject:[dic3 valueForKey:@"new_price"]];
                                                           [temp addObject:[dic3 valueForKey:@"offer_id"]];
                                                           
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
    
    
    
    offer_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"o_cell"];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    
    NSString *str1=[temp objectAtIndex:0];
    
    NSString *ss =@"http://localhost/tifflunbox/";
    NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
    
    [finalstr appendString:str1];
    
    NSURL *url1 =[NSURL URLWithString:finalstr];
    
    NSData *dt1 =[NSData dataWithContentsOfURL:url1];
    
    
    
    c1.img.image = [UIImage imageWithData:dt1];
    c1.offer_name.text=[temp objectAtIndex:1];
    c1.offer_detail.text=[temp objectAtIndex:2
                       ];
    c1.o_price.text=[temp objectAtIndex:3];
    c1.n_price.text=[temp objectAtIndex:4];
    
    
    
    
    
    c1.u_btn.tag=indexPath.row;
    [c1.u_btn addTarget:self action:@selector(myfun2:) forControlEvents:UIControlEventTouchUpInside];
    
   
    return c1;
    
    
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        offer_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"o_cell"];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        [final1 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
        
        NSString *spid=[dif valueForKey:@"spid"];
        
        
        NSString *str=[temp objectAtIndex:5];
        
        final1=[[NSMutableArray alloc]init];
        NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/deleteoffer.php"];
        
        NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&offer_id=%@",spid,str];
        
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        
        NSString *strlen=[NSString stringWithFormat:@"%ld",strbody.length];
        
        [request addValue:strlen forHTTPHeaderField:@"Content-Legnth"];
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:[strbody dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSession *session=[NSURLSession sharedSession];
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    {
                                        
                                        
                                        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        
                                        NSLog(@"%@",str);
                                        
                                        [_tblview reloadData];
                                        
                                    }];
        [task resume];
        
        
    }
}

-(void)myfun2:(UIButton*)button
{
 
    
    offer_cell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [_tblview indexPathForCell:cell];
    NSLog(@"%@", indexPath);
    
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    NSString *str=[temp objectAtIndex:5];
    NSUserDefaults*nsstr=[NSUserDefaults standardUserDefaults];
    [nsstr setObject:str forKey:@"offerid"];
    
    offer_update*i2=[self.storyboard instantiateViewControllerWithIdentifier:@"u_offer"];
    
    [self.navigationController pushViewController:i2 animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    firstpage*f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:f1 animated:NO];
    
}
    
- (IBAction)additem:(id)sender {
    offer_insert*o1=[self.storyboard instantiateViewControllerWithIdentifier:@"o1"];
    
    [self.navigationController pushViewController:o1 animated:YES];
}
@end
