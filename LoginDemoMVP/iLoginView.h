//
//  iLoginView.h
//  LoginDemoMVP
//
//  Created by MM-iMac on 15/10/15.
//  Copyright © 2015 MM-iMac. All rights reserved.
//

#import "User.h"

@protocol iLoginView <NSObject>

@required
- (void)displayLogin:(User *)user;
- (void)displayErrorMessage:(NSString *)errorMessage;
- (void)displayHomeScreen:(User *)user;
@end

