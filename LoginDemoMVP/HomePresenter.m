//
//  WelcomePresenter.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "HomePresenter.h"

#define USERDEFAULTS_DICT_NAME @"UserProfile"


@implementation HomePresenter

- (HomePresenter *)initHomeView:(id <iHomeView>)homeView
{
    if (self = [super init])
    {
        _homeView = homeView;
    }
    
    return self;
}

-(void)logOutTapped
{
    
    [self updateLoggedInStatus:@"loggedOut"];
    [self.homeView logOut];
}

-(void)displayUserName :(User *)user
{
    [self.homeView displayUser:user];
}

-(NSMutableDictionary *)mutableRetrievedDictionary
{
    _mutableRetrievedDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_DICT_NAME] mutableCopy];
    
    return _mutableRetrievedDictionary;
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
