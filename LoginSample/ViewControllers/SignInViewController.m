//
//  ViewController.m
//  test
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@property (nonatomic, weak) UITextField * activeTextField;
@property (nonatomic) CGFloat animatedDistance;

@end

@implementation SignInViewController

@synthesize animatedDistance, activeTextField;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 1.0;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat IOS7_PORTRAIT_KEYBOARD_HEIGHT = 260;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;


//This type of lazy assignment is used so that in unit testing we can mock dependencies
-(AccountService *)accountService {
    if (!_accountService)
    {
        _accountService = [[AccountService alloc]init];
        _accountService.delegate = self;
    }
    return _accountService;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

-(void) setupUI {

    //Align Text for RTL languages
    if([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
        [self alignforRTLLanguage];
    //Following Code is for Arabic Only
    if([[AppUtility getCurrentLanguage] isEqualToString:@"ar"])
        [self setupForArabic];
    
    //hide navigation bar - done to avoid navigation bar errors
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //hide ErrorLabel
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.emailTextField setText:@""];
    [self.passwordTextField setText:@""];
    [self enableUI];
    if ([[AccountService sharedInstance] getSignedInUser] != NULL)
        [self navigateToPaymentScreen];
}

//The following code aligns all text for Right-To-Left Languages to Right-Aligned
- (void) alignforRTLLanguage
{
    ((UILabel *)[self.view viewWithTag:70]).textAlignment = NSTextAlignmentRight;
    self.emailTextField.textAlignment = NSTextAlignmentRight;
    self.passwordTextField.textAlignment = NSTextAlignmentRight;
}

- (void) setupForArabic {
    //Nothing for now
}


-(void)enableUI
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIButton * loginButton = (UIButton *)[self.view viewWithTag:3];
    [loginButton setEnabled:YES];
    UIButton * requestAnInviteButton = (UIButton *)[self.view viewWithTag:4];
    [requestAnInviteButton setEnabled:YES];
    [self.emailTextField setEnabled:YES];
    [self.passwordTextField setEnabled:YES];
}

-(void)disableUI
{
    UIButton * loginButton = (UIButton *)[self.view viewWithTag:3];
    [loginButton setEnabled:NO];
    UIButton * requestAnInviteButton = (UIButton *)[self.view viewWithTag:4];
    [requestAnInviteButton setEnabled:NO];
    [self.emailTextField setEnabled:NO];
    [self.passwordTextField setEnabled:NO];
}

-(void)loginRequestCallback:(BOOL)success failureResponse:(NSString *)response {
    if (success) {
        [self navigateToPaymentScreen];
    }
    else {
        UIAlertView *alertView = [AppUtility createAlertViewWithMessage:response Title:@"Error" Tag:101];
        [alertView show];
        //Show error alert
    }
}

-(void)navigateToPaymentScreen
{
    UserModel * user = [self.accountService getSignedInUser];
    NSLog(@"Signed in User ID: %ld", (long)user.userId);
    NSLog(@"Signed in User Access Token: %@", user.accessToken);
    [self performSegueWithIdentifier:SIGN_IN_TO_PAYMENT_OPTIONS_SEGUE sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Segue ID: %@", segue.identifier);
    //NSLog(@"Crash Logs: prepareForSegue");
    if([segue.identifier isEqualToString:SIGN_IN_TO_PAYMENT_OPTIONS_SEGUE]) {
        //SWRevealViewController *revealViewController = (SWRevealViewController *)segue.destinationViewController;
        //[revealViewController localizedInit];
    }
}

- (IBAction)hideKeyboard:(id)sender {
    
    [activeTextField resignFirstResponder];
}

-(IBAction)loginPressed:(id)sender
{
    [self.view endEditing:YES];
    NSString *userEmail = self.emailTextField.text;
    NSString *userPassword = self.passwordTextField.text;
    [self.accountService makeLoginRequestWithEmailAddress:userEmail
                                              andPassword:userPassword];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag == 1) [self.passwordTextField becomeFirstResponder];
    if (textField.tag == 2) {
        [textField resignFirstResponder];
        [self loginPressed:nil];
    }
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    if (textField.tag == 1) animatedDistance += 30;
    
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    if(textField.tag == 2)  [textField setText:@""];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //same as above but you shift it down
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y =0;//+= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeTextField = textField;
    return YES;
}

@end