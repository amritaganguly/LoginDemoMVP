//
//  ViewController.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "ViewController.h"
#import "LoginHelper.h"
#import "LoginPresenter.h"
#import "LoginRepository.h"
#import "HomeViewController.h"

@interface ViewController ()
{
    id<iLoginRepository> loginRepository;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [LoginHelper createGradientColor:self.view];
    [self hideNavigationBar];
    
   LoginPresenter *loginPresenter = [self instantiateLoginPresenter];
   NSString *status = [loginPresenter fetchLoggedInStatus];

    if ([status caseInsensitiveCompare:@"loggedIn"]==NSOrderedSame)
    {
        User *user =[loginRepository populateLogin];
        [loginPresenter loginTapped:user];
    }
    else
    {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LoginPresenter *)instantiateLoginPresenter
{
    loginRepository = [[LoginRepository alloc] init];
    LoginPresenter *const presenter = [[LoginPresenter alloc]initWithLoginRepository:loginRepository andLoginView:self];
    return presenter;
}

-(void)hideNavigationBar
{
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
}

-(void)displayHomeScreen:(User *)user
{
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeVC =(HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    homeVC.user = user;
    homeVC.navigationItem.hidesBackButton =YES;
    [self.navigationController pushViewController:homeVC animated:YES];
}
@end
