//
//  HomeViewController.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHomeView.h"

//the length of time before your application "times out". This number actually represents seconds, so we'll have to multiple it by 60 in the .m file
#define kApplicationTimeoutInMinutes 60//*60*1

//the notification your AppDelegate needs to watch for in order to know that it has indeed "timed out"
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface HomeViewController : UIViewController <iHomeView>

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (strong, nonatomic) User *user;

- (IBAction)logOutButtonTapped:(id)sender;

@end
