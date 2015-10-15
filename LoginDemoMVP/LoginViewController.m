//
//  LoginViewController.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "LoginRepository.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createGradientColor];
    
    self.txtPassword.delegate =self;
    self.txtUserName.delegate =self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

- (IBAction)loginButtonTapped:(id)sender
{
    if ([self.txtUserName.text length]>0)
    {
        
        if([self.txtPassword.text length]>0)
        {
            User *user =[User userWithName:self.txtUserName.text password:self.txtPassword.text];
            
            LoginPresenter *loginPresenter =[self instantiateLoginPresenter];
            
            [loginPresenter loginTapped:user];
        }
        else
        {
            [self displayErrorMessage:@"Please enter password"];
        }
        
        
    }
    else
    {
        [self displayErrorMessage:@"Please enter username"];
    }
}


- (LoginPresenter *)instantiateLoginPresenter
{
    id<iLoginRepository> loginRepository = [[LoginRepository alloc] init];
    LoginPresenter *const presenter = [[LoginPresenter alloc]initWithLoginRepository:loginRepository andLoginView:self];
    return presenter;
}

-(void)displayHomeScreen:(User *)user
{
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeVC =(HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    homeVC.user = user;
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (void)displayErrorMessage:(NSString *)errorMessage
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:errorMessage
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
