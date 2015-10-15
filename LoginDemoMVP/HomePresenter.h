//
//  WelcomePresenter.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "Presenter.h"
#import "User.h"
#import "iHomeView.h"

@protocol iHomeView;

@interface HomePresenter : Presenter

@property(nonatomic, strong) id<iHomeView> homeView;
@property(nonatomic,strong) NSMutableDictionary *mutableRetrievedDictionary;

- (HomePresenter *)initHomeView:(id <iHomeView>)homeView;
-(void)logOutTapped;
-(void)displayUserName :(User *)user;
@end
