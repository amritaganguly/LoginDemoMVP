//
//  LoginPresenter.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "LoginPresenter.h"
#import "ILoginRepository.h"
#import "ILoginView.h"
#import "LoginRepository.h"



@implementation LoginPresenter

#define USERDEFAULTS_DICT_NAME @"UserProfile"


- (LoginPresenter *)initWithLoginRepository:(id <iLoginRepository>)loginRepository andLoginView:(id <iLoginView>)loginView
{
    if (self = [super init]) {
        self.loginRepository = loginRepository;
        self.loginView = loginView;
        _mutableRetrievedDictionary =[self mutableRetrievedDictionary];
    }
    
    return self;
}



- (void)displayLoginScreen
{
    User *user = [self.loginRepository populateLogin];
    [_loginView displayLogin:user];
    
}

-(void)loginTapped: (User *)user
{
    BOOL status = [self isValidUser:user] ;
    if (status)
    {
        [self createLoggedInUserDictInUserDefaults:user.userName andPassword:user.password];
        [_loginView displayHomeScreen:user];
    }
    else
    {
        [_loginView displayErrorMessage:@"Invalid Credentials"];
    }
    
    
    /*
     if ([user.userName caseInsensitiveCompare:credentials.userName]==NSOrderedSame)
     {
     if ([user.password caseInsensitiveCompare:credentials.password]==NSOrderedSame)
     {
     [self createLoggedInUserDictInUserDefaults:user.userName andPassword:user.password];
     [_loginView displayHomeScreen:user];
     }
     }
     else
     {
     [_loginView displayErrorMessage:@"Invalid Username"];
     }
     */
}


-(BOOL)isValidUser:(User*)user{
    BOOL status = NO ;
    User *credentials =[self.loginRepository populateLogin];
    
    if ([user.userName caseInsensitiveCompare:credentials.userName]==NSOrderedSame)
    {
        if ([user.password caseInsensitiveCompare:credentials.password]==NSOrderedSame)
        {
            status = YES ;
        }
    }
    return status ;
}

-(void)createLoggedInUserDictInUserDefaults : (NSString *)userId andPassword : (NSString *)password
{
    NSMutableDictionary *profileDictionary = [[NSMutableDictionary  alloc] init];
    [profileDictionary setObject:userId forKey:@"userId"];
    [profileDictionary setObject:password forKey:@"password"];
    [profileDictionary setObject:@"loggedIn" forKey:@"status"];
    
    [[NSUserDefaults standardUserDefaults] setObject:profileDictionary forKey:USERDEFAULTS_DICT_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(NSMutableDictionary *)mutableRetrievedDictionary
{
    _mutableRetrievedDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_DICT_NAME] mutableCopy];
    
    return _mutableRetrievedDictionary;
}


-(NSString*)fetchLoggedInStatus
{
    NSString* strStatus = @"" ;
    NSDictionary* dict = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_DICT_NAME];
    strStatus = [dict objectForKey:@"status"];
    return strStatus ;
}

-(void)updateLoggedInStatus : (NSString *)loginStatus
{
    if (_mutableRetrievedDictionary ==nil)
    {
        _mutableRetrievedDictionary =[self mutableRetrievedDictionary];
    }
    
    if ([loginStatus length]>0)
    {
        [_mutableRetrievedDictionary setObject:loginStatus forKey:@"status"];
        
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:_mutableRetrievedDictionary forKey:USERDEFAULTS_DICT_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
