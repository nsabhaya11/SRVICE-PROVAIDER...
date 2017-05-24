//
//  images.m
//  servicesprovaider
//
//  Created by Admin on 16/03/17.
//  Copyright © 2017 mine. All rights reserved.
//

#import "images.h"
#import "images-insert.h"
#import "firstpage.h"
#import "images-cell.h"
#import "images-update.h"

@interface images ()
{
    NSMutableArray *final1;
}

@end

@implementation images

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tbl.allowsMultipleSelectionDuringEditing = NO;
    
    
    
    NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
    
    NSString *spid=[dif valueForKey:@"spid"];
    
    final1=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/select-images.php"];
    
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
                                                           
                                                           
                                                           
                                                           [temp addObject:[dic3 valueForKey:@"images"]];
                                                           [temp addObject:[dic3 valueForKey:@"img_id"]];
                                                           
                                                           
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
    
    
    
    images_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"photo"];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    
    NSString *str1=[temp objectAtIndex:0];
    
    NSString *ss =@"http://localhost/tifflunbox/";
    NSMutableString *finalstr =[[NSMutableString alloc]initWithString:ss];
    [finalstr appendString:str1];
    
    NSURL *url1 =[NSURL URLWithString:finalstr];
    
    NSData *dt1 =[NSData dataWithContentsOfURL:url1];
    
    //  c1.viewlbl.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    
    
    
    
    c1.img.image = [UIImage imageWithData:dt1];
    
    
    c1.updatebtn.tag=indexPath.row;
    
    [c1.updatebtn addTarget:self action:@selector(myfun2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return c1;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        images_cell *c1=[tableView dequeueReusableCellWithIdentifier:@"photo"];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        temp=[final1 objectAtIndex:indexPath.row];
        
        [final1 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
        NSString *tctype=[dif valueForKey:@"tctype"];
        NSString *spid=[dif valueForKey:@"spid"];
        
        
        NSString *str=[temp objectAtIndex:1];
        
        final1=[[NSMutableArray alloc]init];
        NSURL *url=[NSURL URLWithString:@"http://localhost/tifflunbox/deleteimg.php"];
        
        NSString *strbody=[NSString stringWithFormat:@"sp_id=%@&img_id=%@",spid,str];
        
        
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
                                        
                                        [_tbl reloadData];
                                        
                                    }];
        [task resume];
        
        
    }
}


-(void)myfun2:(UIButton*)button
{
   
    images_cell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [_tbl indexPathForCell:cell];
    NSLog(@"%@", indexPath);
    
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    temp=[final1 objectAtIndex:indexPath.row];
    
    NSString *str=[temp objectAtIndex:0];
    NSString *str1=[temp objectAtIndex:1];
    
    
    NSUserDefaults*nsstr=[NSUserDefaults standardUserDefaults];
    [nsstr setObject:str forKey:@"imgstr"];
    
    NSUserDefaults*sstr=[NSUserDefaults standardUserDefaults];
    [sstr setObject:str1 forKey:@"imgid"];
    
    images_update*i2=[self.storyboard instantiateViewControllerWithIdentifier:@"img1"];
    
    [self.navigationController pushViewController:i2 animated:YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addimg:(id)sender {
    
    
    images_insert*i1=[self.storyboard instantiateViewControllerWithIdentifier:@"img"];
    
    [self.navigationController pushViewController:i1 animated:YES];
}

- (IBAction)back:(id)sender {
    
    firstpage*f1=[self.storyboard instantiateViewControllerWithIdentifier:@"f1"];
    
    [self.navigationController pushViewController:f1 animated:NO];
}
@end
