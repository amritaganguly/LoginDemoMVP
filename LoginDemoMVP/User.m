//
//  User.m
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)userWithName:(NSString *)userName
              password:(NSString *)password
{
    User *user = [[User alloc] init];
    
    user.userName = userName;
    user.password = password;
    
    return user;
}

@end
