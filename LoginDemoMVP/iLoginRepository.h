//
//  iLoginRepository.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "User.h"

@protocol iLoginRepository <NSObject>

@required
-(User *)populateLogin;

@end
