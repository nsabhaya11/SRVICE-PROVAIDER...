//
//  selation_homepage.m
//  simpale contoroles examplaes
//
//  Created by Nikunj Patel on 24/09/16.
//  Copyright © 2016 Nikunj Patel. All rights reserved.
//

#import "selation_homepage.h"
#import "select profile.h"
#import "ViewController.h"
#import "login.h"
#import "cart.h"
#import "BBBadgeBarButtonItem.h"
#import <GoogleMaps/GoogleMaps.h>
#import "homepage.h"

@interface selation_homepage ()
{
    UIButton *b1;
    BBBadgeBarButtonItem  * barbutton;
    CLLocationManager *locationManager;
    GMSMapView * mapview;
    UIImageView *img;
}

@end

@implementation selation_homepage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    loc =[[CLLocationManager alloc]init];
    
    loc.delegate = self;

    loc.desiredAccuracy = kCLLocationAccuracyBest;
    [loc requestAlwaysAuthorization];
    [loc requestWhenInUseAuthorization];
  //  loc.delegate = self;
    
    [loc startUpdatingLocation];
    
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0-(self.view.frame.size.width-110), 50,self.view.frame.size.width-110 , self.view.frame.size.height/2)];
    

    UIImage *image = [UIImage imageNamed:@"person-holding-white-ceramic-coffee-cup-leaning-on-brown-wooden-table-free-stock-photo"];
    [view addSubview:image];
    
    view.backgroundColor = [UIColor whiteColor];
    
    
    view.layer.shadowOpacity = 1;
   
    [self.view addSubview:view];
   
    
    
    flag = 0;
    

}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    ceo= [[CLGeocoder alloc]init];
    
    
   NSString *lat = [NSString stringWithFormat:@"%f" ,newLocation.coordinate.latitude];
    
    NSString *log = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    
    NSLog(@"%@",lat);
    
    NSLog(@"%@",log);
    
    
    
    
    [ceo reverseGeocodeLocation:newLocation
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  NSLog(@"placemark %@",placemark);
                  //String to hold address
                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                  NSLog(@"addressDictionary %@", placemark.addressDictionary);
                  
                  NSLog(@"placemark %@",placemark.region);
                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
                  NSLog(@"location %@",placemark.name);
                  NSLog(@"location %@",placemark.ocean);
                  NSLog(@"location %@",placemark.postalCode);
                  NSLog(@"location %@",placemark.subLocality);
                  
                  
                  NSString *str = [NSString stringWithFormat:@"%@",placemark.locality];
                  
                  NSUserDefaults *dif = [NSUserDefaults standardUserDefaults];
                  [dif setObject:locatedAt forKey:@"useraddress"];

                  
                  NSLog(@"location %@",placemark.location);
                  //Print the location to console
                  NSLog(@"I am currently at %@",locatedAt);
                  
                 // NSString *curr = locatedAt;
                  
                  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[lat doubleValue]
                                                                          longitude:[log doubleValue]
                                                                               zoom:6];
                  GMSMapView *mapView = [GMSMapView mapWithFrame:_view1.bounds camera:camera];
                  mapView.myLocationEnabled = YES;
                  
                  
                  //  self.view1 = mapView;
                  
                  // Creates a marker in the center of the map.
                  GMSMarker *marker = [[GMSMarker alloc] init];
                  marker.position = CLLocationCoordinate2DMake([lat doubleValue], [log doubleValue]);
                  marker.title = str;
                  marker.snippet = locatedAt;
                  marker.map = mapView;
                  [self.view1 addSubview: mapView];
                  

                  
                  
                  
                  //_City.text=[placemark.addressDictionary objectForKey:@"City"];
                  [loc stopUpdatingLocation];
                  
                  
                  
              }
     
     ];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        selation_homepage*s1=[self.storyboard instantiateViewControllerWithIdentifier:@"m3"];
        
        [self.navigationController pushViewController:s1 animated:YES];
    }
    else if (indexPath.row==1)
    {
        select_profile *p1=[self.storyboard instantiateViewControllerWithIdentifier:@"s_pro"];
        
        [self.navigationController pushViewController:p1 animated:YES];
    }
    else if (indexPath.row==2)
    {
        
        
    }
    else if (indexPath.row==3)
    {
        
        
    }
    else if (indexPath.row==4)
    {
        UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"" message:@"Sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *btn1 = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            //delete user ID fro user Defaults
            [defaults setObject:nil forKey:@"login_status"];
            //redirect to login view
            
            ViewController *v1 = [self.storyboard instantiateViewControllerWithIdentifier:@"v1"];
            
             [self.navigationController pushViewController:v1 animated:YES];
            
            
        }];
        
        UIAlertAction *btn2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [alt addAction:btn1];
        [alt addAction:btn2];
        [self presentViewController:alt animated:YES completion:nil];
    }
        
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)menubtn:(id)sender {
    
    
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(15, 105, 65, 60)];
    
    vv.layer.cornerRadius = 30;
    
    vv.layer.borderWidth = 2;
    
    
    
    //vv.layer.cornerRadius=btnupload.frame.size.height/2;
    
    vv.clipsToBounds=YES;
    
   
    
    
    UIImageView* image = [[UIImageView alloc]initWithFrame:CGRectMake(50, 80, 60, 60)];
    
    [image setImage:[UIImage imageNamed:@"nik.jpg"]];
    
    [image.layer setBorderColor: [[UIColor brownColor] CGColor]];
    [image.layer setBorderWidth: 1.0];
    
    image.layer.cornerRadius=image.frame.size.height/2;
    
    image.clipsToBounds=YES;
    
    //home
    
    UIButton* homebtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, 160, 50)];
    
    [homebtn setTitle:@"HOME" forState:UIControlStateNormal];
    
    [homebtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [homebtn addTarget:self action:@selector(homepage:) forControlEvents:UIControlEventTouchUpInside];
    
    homebtn.backgroundColor = [UIColor clearColor];
    
    //profile
    
    UIButton* profilebtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 230, 160, 50)];
    
    [profilebtn setTitle:@"PROFILE" forState:UIControlStateNormal];
    
    [profilebtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [profilebtn addTarget:self action:@selector(profile:) forControlEvents:UIControlEventTouchUpInside];
    
    profilebtn.backgroundColor = [UIColor clearColor];
    
    //items
    
    
    //my menu
    
    UIButton* orderbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 260, 160, 50)];
    
    [orderbtn setTitle:@"MY ORDER" forState:UIControlStateNormal];
    
    [orderbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [orderbtn addTarget:self action:@selector(orderpage:) forControlEvents:UIControlEventTouchUpInside];
    
    orderbtn.backgroundColor = [UIColor clearColor];
    
    //offer
    
    UIButton* Cartbtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 290, 160, 50)];
    
    [Cartbtn setTitle:@"MY CART" forState:UIControlStateNormal];
    
    [Cartbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [Cartbtn addTarget:self action:@selector(cartpage:)forControlEvents:UIControlEventTouchUpInside];
    
    Cartbtn.backgroundColor = [UIColor clearColor];
    
    
    
    
    //logout
    
    UIButton *logoutbtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 320, 160, 50)];
    
    [logoutbtn setTitle:@"LOGOUT" forState:UIControlStateNormal];
    
    [logoutbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [logoutbtn addTarget:self action:@selector(logoutset:) forControlEvents:UIControlEventTouchUpInside];
    
    logoutbtn.backgroundColor = [UIColor clearColor];
    
    [view addSubview:logoutbtn];
    
    [view addSubview:homebtn];
    
    [view addSubview:profilebtn];
    
    [view addSubview:Cartbtn];
    
    [view addSubview:orderbtn];
    
    
    [view addSubview:image];
    
    [view addSubview:vv];
    
    
    
    
    
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Blurred-Blue-and-White.jpg"]];
    if (flag == 0)
    {
        
        
        [UIView beginAnimations:NULL context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        
        view.frame = CGRectMake(0, 50,self.view.frame.size.width-110 , self.view.frame.size.height);
        
        [UIView commitAnimations];
        
        flag=1;
        
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        // add this new view to your main view
        [self.view addSubview:view];
        
        
    }else if (flag==1)
    
    {
        [UIView beginAnimations:NULL context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        
        view.frame = CGRectMake(0-(self.view.frame.size.width-110), 50,self.view.frame.size.width-110 , self.view.frame.size.height);
        
        [UIView commitAnimations];
        
        flag=0;
        
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        // add this new view to your main view
        [self.view addSubview:view];
        
        
    }
    
        
    
}
-(void)homepage:(UIButton *)sender
    {
        selation_homepage*s1=[self.storyboard instantiateViewControllerWithIdentifier:@"m3"];
        
        [self.navigationController pushViewController:s1 animated:YES];
    }
    
-(void)profile:(UIButton *)sender
    {
        select_profile *p1=[self.storyboard instantiateViewControllerWithIdentifier:@"s_pro"];
        
        [self.navigationController pushViewController:p1 animated:YES];
    }

-(void)cartpage:(UIButton *)sender
    {
        
    }
    
-(void)orderpage:(UIButton *)sender
    {
        
    }
    
-(void)logoutset:(UIButton *)sender
    {
        UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"" message:@"Sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *btn1 = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            //delete user ID fro user Defaults
            [defaults setObject:nil forKey:@"login_status"];
            //redirect to login view
            
            ViewController *v1 = [self.storyboard instantiateViewControllerWithIdentifier:@"v1"];
            
            [self.navigationController pushViewController:v1 animated:YES];
            
            
        }];
        
        UIAlertAction *btn2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [alt addAction:btn1];
        [alt addAction:btn2];
        [self presentViewController:alt animated:YES completion:nil];
    }


    
- (IBAction)clickhear:(id)sender {
    homepage*u1=[self.storyboard instantiateViewControllerWithIdentifier:@"homepage"];
    
    [self.navigationController pushViewController:u1 animated:YES];
}

- (IBAction)cart:(id)sender {
    cart *c1=[self.storyboard instantiateViewControllerWithIdentifier:@"cart"];
    
    [self.navigationController pushViewController:c1 animated:NO];
}

@end
