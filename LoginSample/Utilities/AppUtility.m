//
//  AppUtility.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "AppUtility.h"

@implementation AppUtility

+ (NSLocaleLanguageDirection) getCurrentLanguageDirection {
    return [NSLocale characterDirectionForLanguage: [NSLocale preferredLanguages][0]];
}

+ (NSString *) getCurrentLanguage {
    return [NSLocale preferredLanguages][0];
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+(UIAlertView *)createAlertViewWithMessage:(NSString *) message Title:(NSString *)title Tag:(NSInteger)tag {
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    alertView.tag  = tag;
    return alertView;
}


@end
