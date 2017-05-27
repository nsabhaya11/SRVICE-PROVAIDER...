//
//  selation_homepage.h
//  simpale contoroles examplaes
//
//  Created by Nikunj Patel on 24/09/16.
//  Copyright © 2016 Nikunj Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface selation_homepage : UIViewController<NSLayoutManagerDelegate,CLLocationManagerDelegate>
{
    UIView* view;
    NSArray* arr;
    int flag;
    
    CLLocationManager *loc;
    
    CLGeocoder *ceo;
    
}

- (IBAction)menubtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *menubtn;
- (IBAction)clickhear:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *clickhear;

- (IBAction)cart:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *navibar;
@property (weak, nonatomic) IBOutlet UIView *view1;




@end
