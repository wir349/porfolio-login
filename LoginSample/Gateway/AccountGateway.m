//
//  AccountGateway.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "AccountGateway.h"

@implementation AccountGateway

-(void)requestLoginWithEmail:(NSString *)emailAddress andPassword: (NSString *) password {
    AFHTTPSessionManager *manager = [self createLoggedOutHTTPSessionManager];
    if (manager) {
        NSString *apiCall = [self createAPI:API_LOGIN withParameters:@""];
        [manager GET:apiCall parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            //In a real app, I would be sending the response object
            NSDictionary *userDic = @{USER_EMAIL_KEY: @"wir349@gmail.com",
                                     USER_ID_KEY: @"349",
                                     USER_PHONE_NUMBER_KEY: @"9516421363",
                                     USER_ACCESS_TOKEN_KEY: @"321QWERTY",
                                     USER_FIRST_NAME_KEY: @"Waleed",
                                     USER_LAST_NAME_KEY: @"Rahman"};
            [self.gatewayDelegate respondLoginSuccessWithResponseObject:userDic];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //In a real app, I would be returning the error description and success false
            NSDictionary *userDic = @{USER_EMAIL_KEY: @"wir349@gmail.com",
                                     USER_ID_KEY: @"349",
                                     USER_PHONE_NUMBER_KEY: @"9516421363",
                                     USER_ACCESS_TOKEN_KEY: @"321QWERTY",
                                     USER_FIRST_NAME_KEY: @"Waleed",
                                     USER_LAST_NAME_KEY: @"Rahman"};
            [self.gatewayDelegate respondLoginSuccessWithResponseObject:userDic];
        }];
    }

}


@end
