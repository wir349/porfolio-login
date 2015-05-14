//
//  UserModel.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding> 

@property(nonatomic, retain, readonly) NSString * phoneNumber;
@property(nonatomic, readonly) NSInteger userId;
@property(nonatomic, retain, readonly) NSString * email;
@property(nonatomic, retain, readonly) NSString * firstName;
@property(nonatomic, retain, readonly) NSString * lastName;
@property(nonatomic, retain, readonly) NSString * accessToken;

-(instancetype)initWithDictionary:(NSDictionary *)userDictionary NS_DESIGNATED_INITIALIZER;

@end
