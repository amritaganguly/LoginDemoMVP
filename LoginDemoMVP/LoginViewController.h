//
//  LoginViewController.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iLoginView.h"
#import "LoginPresenter.h"

@interface LoginViewController : UIViewController<iLoginView,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet LoginPresenter *presenter;

@property (strong,nonatomic) User * user;


- (IBAction)loginButtonTapped:(id)sender;


@end
