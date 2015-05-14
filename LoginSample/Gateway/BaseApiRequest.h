//
//  BaseApiRequest.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface BaseApiRequest : NSObject

@property (NS_NONATOMIC_IOSONLY, readonly, copy) AFHTTPSessionManager *createLoggedOutHTTPSessionManager;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) AFHTTPSessionManager *createHTTPSessionManager;

-(NSString *) createAPI:(NSString *)apiString withParameters:(NSString *)parameters;


@end
