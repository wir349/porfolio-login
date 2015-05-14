//
//  BaseApiRequest.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "BaseApiRequest.h"

@implementation BaseApiRequest

-(AFHTTPSessionManager *)createHTTPSessionManager {
    UserModel * user = [[AccountService sharedInstance] getSignedInUser];
    if (user) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASR_URL]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)user.userId]
                         forHTTPHeaderField:API_USER_ID_HEADER_KEY];
        [manager.requestSerializer setValue:user.accessToken
                         forHTTPHeaderField:API_ACCESS_TOKEN_HEADER_KEY];
        
        //New Header fields
        [manager.requestSerializer setValue:user.accessToken
                         forHTTPHeaderField:API_AUTHORIZATION_HEADER_KEY];
        
        [manager.requestSerializer setValue:@"ICMA"
                         forHTTPHeaderField:API_AGENT_HEADER_KEY];
        
        [manager.requestSerializer setValue:API_PROVIDER_ACCESS_TOKEN
                         forHTTPHeaderField:API_PROVIDER_ACCESS_HEADER_KEY];
        
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        return manager;
    }
    return nil;
}


-(AFHTTPSessionManager *)createLoggedOutHTTPSessionManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASR_URL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:API_AGENT_HEADER
                     forHTTPHeaderField:API_AGENT_HEADER_KEY];
    [manager.requestSerializer setValue:API_PROVIDER_ACCESS_TOKEN
                     forHTTPHeaderField:API_PROVIDER_ACCESS_HEADER_KEY];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

-(NSString *) createAPI:(NSString *)apiString withParameters:(NSString *)parameters
{
    return [NSString stringWithFormat:@"%@?%@&device=ICMA&lang=%@", apiString, parameters, [AppUtility getCurrentLanguage]];
}

@end
