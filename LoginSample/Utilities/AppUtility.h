//
//  AppUtility.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppUtility : NSObject

+ (NSLocaleLanguageDirection) getCurrentLanguageDirection;

+ (NSString *) getCurrentLanguage;

+ (BOOL) validateEmail: (NSString *) candidate;

+(UIAlertView *)createAlertViewWithMessage:(NSString *) message Title:(NSString *)title Tag:(NSInteger)tag;


@end
