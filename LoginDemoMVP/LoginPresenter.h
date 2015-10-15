//
//  LoginPresenter.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "Presenter.h"
#import "User.h"

@protocol iLoginView;
@protocol iLoginRepository;

@interface LoginPresenter : Presenter

@property(nonatomic, strong) id<iLoginView> loginView;
@property(nonatomic, strong) id<iLoginRepository> loginRepository;
@property(nonatomic,strong) NSMutableDictionary *mutableRetrievedDictionary;

- (LoginPresenter *)initWithLoginRepository:(id <iLoginRepository>)loginRepository andLoginView:(id <iLoginView>)loginView;


-(void)displayLoginScreen;
-(void)loginTapped: (User *)user;
-(BOOL)isValidUser:(User*)user ;
-(void)createLoggedInUserDictInUserDefaults : (NSString *)userId andPassword : (NSString *)password;
-(NSString*)fetchLoggedInStatus;
-(void)updateLoggedInStatus : (NSString *)loginStatus;


@end
