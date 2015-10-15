//
//  LoginRepository.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "LoginRepository.h"

@implementation LoginRepository


-(User *)populateLogin
{
    User *user =[User userWithName:@"Amby" password:@"123"];
    return user;
}

@end
