//
//  AccountService.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountGateway.h"
#import "Reachability.h"

@protocol AccountServiceDelegate <NSObject>

@optional

//Signin View Controller
- (void) loginRequestCallback:(BOOL)success failureResponse:(NSString*) response;

@end

@interface AccountService : NSObject<AccountGatewayDelegate>

@property (nonatomic,weak) id<AccountServiceDelegate> delegate;

+(AccountService *)sharedInstance;

@property (nonatomic, strong) AccountGateway * accountGateway;

@property (nonatomic, strong) NSUserDefaults *userDefaults;

-(void)makeLoginRequestWithEmailAddress:(NSString *)emailAddress andPassword:(NSString *)password;

-(BOOL)validateRfcCompliantEmail: (NSString *) candidate;

-(void) signOutUser;

@property (NS_NONATOMIC_IOSONLY, getter=getSignedInUser, readonly, strong) UserModel *signedInUser;


@end
