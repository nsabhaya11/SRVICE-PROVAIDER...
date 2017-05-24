//
//  thirdpage.m
//  servicesprovaider
//
//  Created by MACOS on 12/26/16.
//  Copyright © 2016 mine. All rights reserved.
//

#import "thirdpage.h"
#import "firstpage.h"
#import "menu-cell.h"
#import "item-insert.h"
#import "item-update.h"
@interface thirdpage ()

    {
        NSMutableArray *final1;
    }
@end



@implementation thirdpage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblview.allowsMultipleSelectionDuringEditing = NO;
    
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    NSString *tctype=[dif valueForKey:@"tctype"];
    NSString *spid=[dif valueForKey:@"spid"];
    
    final1=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select-itemmenu.php"];
    
    NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type=%@",spid,tctype];
    
    
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
                                                           
                                                           
                                                           
                                                           [temp addObject:[dic3 valueForKey:@"item_img"]];
                                                           [temp addObject:[dic3 valueForKey:@"item_name"]];
                                                           [temp addObject:[dic3 valueForKey:@"item_price"]];
                                                           [temp addObject:[dic3 valueForKey:@"item_id"]];
                                                           
                                                           [final1 addObject:temp];
                                                           
                                                           
                                                           
                                                           
                                                       }
                                                       
                                                       [_tblview reloadData];
                                                       
                                                       
                                                       
                                                       
                                                       
                                                   });
                                    
                                    
                                }];
    
    
    [task resume];
    

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
        
        
        
        menu_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"menu"];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        
       NSString *str1=[temp objectAtIndex:0];
        
        NSString *ss =@"http://localhost/tifflunbox/";
        NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
        
        [finalstr appendString:str1];
        
        NSURL *url1 =[NSURL URLWithString:finalstr];
        
        NSData *dt1 =[NSData dataWithContentsOfURL:url1];
        
    
        
        c1.itemimg.image = [UIImage imageWithData:dt1];
        c1.itemname.text=[temp objectAtIndex:1];
        c1.itemprice.text=[temp objectAtIndex:2
                           ];
        
        c1.staper.tag  = indexPath.row;
      
        
        
        c1.updatebtn.tag=indexPath.row;
        [c1.updatebtn addTarget:self action:@selector(myfun2:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return c1;
        
   
        
    }




- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
  
-(void)myfun2:(UIButton*)button
    {
        
        item_update*i2=[self.storyboard instantiateViewControllerWithIdentifier:@"i2"];
        
        [self.navigationController pushViewController:i2 animated:YES];
        
        menu_cell *cell = (UITableViewCell *)button.superview.superview;
        NSIndexPath *indexPath = [_tblview indexPathForCell:cell];
        NSLog(@"%@", indexPath);
        
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        NSString *str=[temp objectAtIndex:3];
        NSUserDefaults*nsstr=[NSUserDefaults standardUserDefaults];
        [nsstr setObject:str forKey:@"itemid"];
        
    }
    

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        menu_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"menu"];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        [final1 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
        NSString *tctype=[dif valueForKey:@"tctype"];
        NSString *spid=[dif valueForKey:@"spid"];
       
        
        NSString *str=[temp objectAtIndex:3];
        
        final1=[[NSMutableArray alloc]init];
        NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/deletitem.php"];
        
        NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&tc_type=%@&item_id=%@",spid,tctype,str];
        
        
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


- (IBAction)additem:(id)sender {
    
    item_insert*i1=[self.storyboard instantiateViewControllerWithIdentifier:@"iteminsert"];
    
    [self.navigationController pushViewController:i1 animated:YES];
    
}
@end
