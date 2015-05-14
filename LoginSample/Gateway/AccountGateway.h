//
//  AccountGateway.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApiRequest.h"

@protocol AccountGatewayDelegate <NSObject>

-(void)respondLoginSuccessWithResponseObject:(NSObject *)responseObject;

-(void)respondLoginFailedWithErrorMessage:(NSString *)errorMessage;

@end


@interface AccountGateway : BaseApiRequest

-(void)requestLoginWithEmail:(NSString *)emailAddress andPassword: (NSString *) password;

@property (nonatomic,weak) id<AccountGatewayDelegate> gatewayDelegate;


@end
