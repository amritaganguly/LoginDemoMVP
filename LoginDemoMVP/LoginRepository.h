//
//  LoginRepository.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILoginRepository.h"


@interface LoginRepository : NSObject <iLoginRepository>
-(User *)populateLogin;
@end
