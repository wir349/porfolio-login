//
//  AccountService.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "AccountService.h"

@interface AccountService ()


@end

@implementation AccountService

+(AccountService *)sharedInstance {
    
    static dispatch_once_t pred;
    static AccountService *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[AccountService alloc] init];
    });
    return shared;
}

-(AccountGateway *)accountGateway {
    if (!_accountGateway)
    {
        _accountGateway = [[AccountGateway alloc]init];
        _accountGateway.gatewayDelegate = self;
    }
    return _accountGateway;
}

-(NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        return [NSUserDefaults standardUserDefaults];
    }
    else
        return _userDefaults;
}

-(void)makeLoginRequestWithEmailAddress:(NSString *)emailAddress andPassword:(NSString *)password
{
    if(![self isInternetAvailable]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(loginRequestCallback: failureResponse:)])
            [self.delegate loginRequestCallback:NO failureResponse:@"No Internet Connection"];
    }
    else if (![self isValidEmailAddress:emailAddress andPassword:password]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(loginRequestCallback: failureResponse:)])
            [self.delegate loginRequestCallback:NO failureResponse:@"Incorrect Email / Password Format"];
    }
    else {
        [self.accountGateway requestLoginWithEmail:emailAddress andPassword:password];
    }
}


-(void)respondLoginSuccessWithResponseObject:(NSObject *)responseObject
{
    if (responseObject) {
        //Parse and save user object
        UserModel *userModel = [[UserModel alloc] initWithDictionary:(NSDictionary *)responseObject];
        [self storeSignedInUser:userModel];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(loginRequestCallback: failureResponse:)])
            [self.delegate loginRequestCallback:YES failureResponse:nil];
    }
    else {
        if(self.delegate && [self.delegate respondsToSelector:@selector(loginRequestCallback: failureResponse:)])
            [self.delegate loginRequestCallback:NO failureResponse:@"Empty Response"];
    }
}

-(void)respondLoginFailedWithErrorMessage:(NSString *)errorMessage {
    if(self.delegate && [self.delegate respondsToSelector:@selector(loginRequestCallback: failureResponse:)])
        [self.delegate loginRequestCallback:NO failureResponse:errorMessage];
}


-(BOOL)isInternetAvailable
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
        return NO;
    else
        return YES;
}

-(BOOL)isValidEmailAddress:(NSString *)emailAddress andPassword:(NSString *)password {
    emailAddress = [emailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([emailAddress length] > 1 &&
        [self validateRfcCompliantEmail:emailAddress] &&
        [password length] >= 5)
        return YES;
    return NO;
}

#pragma mark Email Address Helper Functions
-(BOOL) validateRfcCompliantEmail: (NSString *) candidate
{
    if ([candidate rangeOfString:@"@"].location == NSNotFound)
        return NO;
    
    NSString *emailRegex = @"^([\\!#\\$%&'\\*\\+\\/\\=?\\^`\{\\|\\}~a-zA-Z0-9_-]+[\\.]?)+[\\!#\\$%&'\\*\\+\\/\\=?\\^`\\{\\|\\}~a-zA-Z0-9_-]+@{1}((([0-9A-Za-z_-]+)([\\.]{1}[0-9A-Za-z_-]+)*\\.{1}([A-Za-z]){1,6})|(([0-9]{1,3}[\\.]{1}){3}([0-9]{1,3}){1}))$";
    
    NSError * err = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc]initWithPattern:emailRegex options:NSRegularExpressionDotMatchesLineSeparators error:&err];
    NSInteger boolMatch = [regx numberOfMatchesInString:candidate options:0 range:NSMakeRange(0, candidate.length)];
    return boolMatch;
}
- (BOOL) validatePassword: (NSString *) candidate {
    NSString *passwordRegex;
    if ([[AppUtility getCurrentLanguage] isEqualToString:@"ar"])
        passwordRegex = @"^[\\S]{5,}$";
    else
        passwordRegex = @"^[A-Za-z0-9$@#%&*!]{5,}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:candidate];
}

#define UserDefault Utility methods

-(UserModel*) getSignedInUser
{
    UserModel * userModel = [[UserModel alloc]init];
    NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
    @try {
        userModel = (UserModel *)[NSKeyedUnarchiver unarchiveObjectWithData:[userDefault objectForKey:SIGNED_IN_USER_KEY]];
    }
    @catch (NSException *exception) {
        NSLog(@"NSException: %@", exception.name);
        [self storeSignedInUser:nil];
    }
    @finally {
        return userModel;
    }
    
}

-(void)storeSignedInUser:(UserModel * )signedInUserModel
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSData * signedInUserData = [NSKeyedArchiver archivedDataWithRootObject:signedInUserModel];
    [userDefault setObject:signedInUserData forKey:SIGNED_IN_USER_KEY];
    [userDefault synchronize];
}

-(void) signOutUser {
    [self.userDefaults removeObjectForKey:SIGNED_IN_USER_KEY];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [self.userDefaults removePersistentDomainForName:appDomain];
    [self.userDefaults synchronize];
}


@end
