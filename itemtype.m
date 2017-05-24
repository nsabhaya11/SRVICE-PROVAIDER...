//
//  itemtype.m
//  servicesprovaider
//
//  Created by Admin on 19/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "itemtype.h"
#import "itemtype_cell.h"
#import "item-insert.h"
#import "thirdpage.h"
#import "firstpage.h"

@interface itemtype ()
    
    {
        NSMutableArray *final1;
    }

@end

@implementation itemtype

- (void)viewDidLoad {
    [super viewDidLoad];
    
    final1=[[NSMutableArray alloc]init];
    
    NSUserDefaults *nsstr=[NSUserDefaults standardUserDefaults];
    NSString *spid=[nsstr valueForKey:@"spid"];
    NSLog(@"%@",spid);
    

    
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/item_picker_select.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@",spid];
    
    
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
                                                       
                                                       for (NSDictionary *dic3 in arr) {
                                                           
                                                           NSMutableArray *temp=[[NSMutableArray alloc]init];
                                                           
                                                           
                                                           [temp addObject:[dic3 valueForKey:@"tc_type"]];
                                                           
                                                           
                                                           
                                                           
                                                           [final1 addObject:temp];
                                                           
                                                           NSLog(@"%@",final1);
                                                           
                                                       }
                                                       
                                                       [_tbl reloadData];
                                                   });
                                }];
    
    
    [task resume];

    
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
        return [final1 count];
    }
    
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        
        
        itemtype_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"itemtype"];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        
        c1.item_type.text=[temp objectAtIndex:0];
        
    
        
        return c1;
        
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        NSString *tctype=[temp objectAtIndex:0];
        
        NSUserDefaults*nsstr=[NSUserDefaults standardUserDefaults];
        [nsstr setObject:tctype forKey:@"tctype"];
        
        
        
        thirdpage*t3=[self.storyboard instantiateViewControllerWithIdentifier:@"t3"];
        
        [self.navigationController pushViewController:t3 animated:YES];

    }

- (IBAction)additem:(id)sender {
    
    item_insert *i1=[self.storyboard instantiateViewControllerWithIdentifier:@"iteminsert"];
    
    [self.navigationController pushViewController:i1 animated:YES];
    
    
}
- (IBAction)back:(id)sender {
    
    firstpage *f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:f1 animated:NO];
}
@end
