//
//  HomeViewController.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomePresenter.h"

@interface HomeViewController ()
{
    NSTimer     *myidleTimer;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createGradientColor];
    self.navigationItem.hidesBackButton =YES;
    
    
    HomePresenter *homePresenter =[[HomePresenter alloc] initHomeView:self];
    [homePresenter displayUserName:self.user];
    
    
    [self resetIdleTimer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];

}


-(void)resetIdleTimer
{
    if (myidleTimer)
    {
        [myidleTimer invalidate];
    }
    //convert the wait period into minutes rather than seconds
    double timeout = kApplicationTimeoutInMinutes ;
    myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    
}

//if the timer reaches the limit as defined in kApplicationTimeoutInMinutes, post this notification
-(void)idleTimerExceeded
{
    if (myidleTimer)
    {
        [myidleTimer invalidate];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

-(void)displayUser:(User *)user
{
   self.lblUserName.text =self.user.userName;
}

-(void)logOut
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createGradientColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[self colorFromHexString:@"#F12D26"] CGColor], (id)[[self colorFromHexString:@"#FF6B44"] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}


- (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (IBAction)logOutButtonTapped:(id)sender
{
    HomePresenter *homePresenter =[[HomePresenter alloc] initHomeView:self];
    [homePresenter logOutTapped];
}

-(void)applicationDidTimeout : (NSNotification *)notif
{
    [self logOut];
}
@end
