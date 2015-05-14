//
//  UserModel.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:_userId forKey:USER_ID_KEY];
    [encoder encodeObject:_email forKey:USER_EMAIL_KEY];
    [encoder encodeObject:_phoneNumber forKey:USER_PHONE_NUMBER_KEY];
    [encoder encodeObject:_firstName forKey:USER_FIRST_NAME_KEY];
    [encoder encodeObject:_lastName forKey:USER_LAST_NAME_KEY];
    [encoder encodeObject:_accessToken forKey:USER_ACCESS_TOKEN_KEY];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        _userId = [decoder decodeIntegerForKey:USER_ID_KEY];
        _email = [decoder decodeObjectForKey:USER_EMAIL_KEY];
        _phoneNumber = [decoder decodeObjectForKey:USER_PHONE_NUMBER_KEY];
        _firstName = [decoder decodeObjectForKey:USER_FIRST_NAME_KEY];
        _lastName = [decoder decodeObjectForKey:USER_LAST_NAME_KEY];
        _accessToken = [decoder decodeObjectForKey:USER_ACCESS_TOKEN_KEY];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)userDictionary {
    if((self = [super init])) {
        _userId = [userDictionary[USER_ID_KEY] integerValue];
        _email = userDictionary[USER_EMAIL_KEY];
        _firstName = userDictionary[USER_FIRST_NAME_KEY];
        _lastName = userDictionary[USER_LAST_NAME_KEY];
        _accessToken = userDictionary[USER_ACCESS_TOKEN_KEY];
        _phoneNumber = userDictionary[USER_PHONE_NUMBER_KEY];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%ld %@ %@ %@ %@ %@", (long)self.userId, self.email, self.firstName, self.lastName,  self.accessToken, self.phoneNumber];
}



@end
