//
//  ViewController.h
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountService.h"
#import "BaseUITextField.h"

@interface SignInViewController : UIViewController<AccountServiceDelegate>

@property(nonatomic,retain) IBOutlet BaseUITextField * emailTextField;
@property(nonatomic,retain) IBOutlet BaseUITextField * passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (nonatomic, strong) AccountService *accountService;


- (IBAction)hideKeyboard:(id)sender;
-(IBAction)loginPressed:(id)sender;



@end

