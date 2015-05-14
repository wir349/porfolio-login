//
//  BaseViewController.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//@property (nonatomic, strong) AlertViewUtility *alertViewUtility;

@property (nonatomic, strong) UIBarButtonItem * localizedRightBarButton;
@property (nonatomic, strong) UIBarButtonItem * localizedLeftBarButton;

- (void)viewDidLoad;

-(void)addParentChildEquivalentConstraintsToParent:(UIView *)parentView forChild:(UIView *)childView;

//-(void)showAlertViewWithTag:(NSInteger)tag;

@end
