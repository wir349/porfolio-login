//
//  BaseViewController.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super initWithCoder:aDecoder]) {
        //alertViewUtility = [[AlertViewUtility alloc] initWithViewController:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBarStyle];
}

-(void)setupNavBarStyle
{
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setBarTintColorForNavBar];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)setBarTintColorForNavBar{
    UIColor *color = NAV_BAR_COLOR;

    if(IS_IOS7)
        [self.navigationController.navigationBar setBarTintColor:color];
    else {
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundColor:color];
    }
}

-(UIBarButtonItem *)localizedRightBarButton {
    if ([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
        return self.navigationItem.leftBarButtonItem;
    else
        return self.navigationItem.rightBarButtonItem;
}

-(UIBarButtonItem *)localizedLeftBarButton {
    if ([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
        return self.navigationItem.rightBarButtonItem;
    else
        return self.navigationItem.leftBarButtonItem;
}

-(void)setLocalizedRightBarButton:(UIBarButtonItem *)localizedRightBarButton {
    if ([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
        self.navigationItem.leftBarButtonItem = localizedRightBarButton;
    else
        self.navigationItem.rightBarButtonItem = localizedRightBarButton;
}

-(void)setLocalizedLeftBarButton:(UIBarButtonItem *)localizedLeftBarButton {
    if ([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
        self.navigationItem.rightBarButtonItem = localizedLeftBarButton;
    else
        self.navigationItem.leftBarButtonItem = localizedLeftBarButton;
}

- (void)addParentChildEquivalentConstraintsToParent:(UIView*)parentView forChild:(UIView *)childView {
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:childView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:childView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:childView
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:childView
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:0.0]];
}

//-(void)showAlertViewWithTag:(NSInteger)tag {
//    [self.alertViewUtility showAlertViewWithTag:tag];
//}


@end
