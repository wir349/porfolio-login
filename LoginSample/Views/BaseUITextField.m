//
//  BaseUITextField.m
//  
//
//  Created by Waleed Rahman on 5/12/15.
//
//  Utility Class which helps save redundant code for all textFields in VCs
//  and keeps VCs a bit cleaner

#import "BaseUITextField.h"

@implementation BaseUITextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addLeftRightView];
        if([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
            self.textAlignment = NSTextAlignmentRight;
        [[UITextField appearance] setTintColor:TEXT_COLOR];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self addLeftRightView];
        if([AppUtility getCurrentLanguageDirection] == NSLocaleLanguageDirectionRightToLeft)
            self.textAlignment = NSTextAlignmentRight;
        [[UITextField appearance] setTintColor:TEXT_COLOR];
    }
    return self;
}

-(void)addLeftRightView
{
    self.leftView = [self getTextFieldLeftView];
    self.leftViewMode = UITextFieldViewModeAlways;
    
    self.rightView = [self getTextFieldRightView];
    self.rightViewMode = UITextFieldViewModeAlways;
}


-(UIView *)getTextFieldLeftView
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 5)];
    
}

-(UIView *)getTextFieldRightView
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 5)];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
