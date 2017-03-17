//
//  CompleViewController.m
//  petcamera
//
//  Created by czx on 2017/2/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "CompleViewController.h"
#import "ShareWork+Login.h"
@interface CompleViewController ()
@property (nonatomic,strong)UIButton * codeBtn;
@property (nonatomic,strong)UITextField * emailTextfield;
@property (nonatomic,strong)UITextField * codeTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@property (nonatomic,strong)UITextField * surePasswordfield;

@property (nonatomic,strong)NSString * achieveString;
@property (nonatomic,strong)NSString * codeNumber;
@end

@implementation CompleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Forgot Password"];
    // self.view.backgroundColor = LIGHT_GRAYdcdc_COLOR;
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
}

-(void)setupView{
    UIView * firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.layer.borderColor = RED_COLOR.CGColor;
    firstView.layer.borderWidth = 1;
    firstView.layer.cornerRadius = 25;
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.superview).offset(15);
        make.right.equalTo(firstView.superview).offset(-15);
        make.top.equalTo(firstView.superview).offset(10);
        make.height.mas_equalTo(50);
        
    }];
    
    _emailTextfield = [[UITextField alloc]init];
    _emailTextfield.textColor =YELLOW_COLOR;
    _emailTextfield.tintColor = YELLOW_COLOR;
    _emailTextfield.placeholder = @"Enter your email";
    [_emailTextfield setValue:YELLOW_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _emailTextfield.font = [UIFont systemFontOfSize:18];
    _emailTextfield.keyboardType = UIKeyboardTypeAlphabet;
    [firstView addSubview:_emailTextfield];
    [_emailTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_emailTextfield.superview.mas_left).offset(10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(_emailTextfield.superview.mas_centerY);
    }];
    
    
    _codeBtn = [[UIButton alloc]init];
    _codeBtn.backgroundColor = RGB(245, 145, 40);
    [_codeBtn setTitle:@"Send Code" forState:UIControlStateNormal];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _codeBtn.titleLabel.numberOfLines = 2;
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _codeBtn.layer.cornerRadius = 22;
    [_codeBtn addTarget:self action:@selector(codebuttontouch) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_codeBtn.superview.mas_right).offset(-2.5);
        make.top.equalTo(_codeBtn.superview.mas_top).offset(2.5);
        make.bottom.equalTo(_codeBtn.superview.mas_bottom).offset(-2.5);
        make.width.mas_equalTo(65);
        
    }];
    
    UIView * secoendView = [[UIView alloc]init];
    secoendView.backgroundColor = [UIColor whiteColor];
    secoendView.layer.borderColor = RED_COLOR.CGColor;
    secoendView.layer.borderWidth = 1;
    secoendView.layer.cornerRadius = 25;
    [self.view addSubview:secoendView];
    [secoendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secoendView.superview).offset(15);
        make.right.equalTo(secoendView.superview).offset(-15);
        make.top.equalTo(firstView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
        
    }];
    
    _codeTextfield = [[UITextField alloc]init];
    _codeTextfield.tintColor = YELLOW_COLOR;
    _codeTextfield.textColor = YELLOW_COLOR;
    _codeTextfield.placeholder = @"Enter your verification code";
    [_codeTextfield setValue:YELLOW_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _codeTextfield.font = [UIFont systemFontOfSize:18];
    _codeTextfield.keyboardType = UIKeyboardTypeNumberPad;
    [secoendView addSubview:_codeTextfield];
    [_codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeTextfield.superview.mas_left).offset(10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(_codeTextfield.superview.mas_centerY);
        
    }];
    
    UIView * passView = [[UIView alloc]init];
    passView.backgroundColor =  [UIColor whiteColor];
    passView.layer.borderColor = RED_COLOR.CGColor;
    passView.layer.borderWidth = 1;
    passView.layer.cornerRadius = 25;
    [self.view addSubview:passView];
    [passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passView.superview).offset(15);
        make.right.equalTo(passView.superview).offset(-15);
        make.top.equalTo(secoendView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
        
    }];
    
    _passwordTextfield = [[UITextField alloc]init];
    _passwordTextfield.tintColor = YELLOW_COLOR;
    _passwordTextfield.textColor = YELLOW_COLOR;
    _passwordTextfield.placeholder = @"Enter password(at least 6 digits)";
    [_passwordTextfield setValue:YELLOW_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextfield.keyboardType = UIKeyboardTypeAlphabet;
    [passView addSubview:_passwordTextfield];
    [_passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordTextfield.superview.mas_left).offset(10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(_passwordTextfield.superview.mas_centerY);
        
    }];
    
    UIView * surepassView = [[UIView alloc]init];
    surepassView.backgroundColor = [UIColor whiteColor];
    surepassView.layer.borderWidth = 1;
    surepassView.layer.borderColor = RED_COLOR.CGColor;
    surepassView.layer.cornerRadius = 25;
    [self.view addSubview:surepassView];
    [surepassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(surepassView.superview).offset(15);
        make.right.equalTo(surepassView.superview).offset(-15);
        make.top.equalTo(passView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
        
        
    }];
    
    _surePasswordfield = [[UITextField alloc]init];
    _surePasswordfield.textColor = YELLOW_COLOR;
    _surePasswordfield.tintColor = YELLOW_COLOR;
    _surePasswordfield.placeholder = @"Re-enter password";
    [_surePasswordfield setValue:YELLOW_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _surePasswordfield.keyboardType =UIKeyboardTypeAlphabet;
    [surepassView addSubview:_surePasswordfield];
    [_surePasswordfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_surePasswordfield.superview.mas_left).offset(10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(_surePasswordfield.superview.mas_centerY);
    }];
    
    UIButton * registBtn = [[UIButton alloc]init];
    registBtn.backgroundColor = YELLOW_COLOR;
    [registBtn setTitle:@"Done" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:registBtn];
    [registBtn addTarget:self action:@selector(regiestButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registBtn.superview).offset(15);
        make.right.equalTo(registBtn.superview).offset(-15);
        make.top.equalTo(surepassView.mas_bottom).offset(25);
        make.height.mas_equalTo(50);
    }];
    
}


-(void)codebuttontouch{
    if ([AppUtil isBlankString:_emailTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter your email"];
        return;
    }
    if (![AppUtil isValidateEmail:_emailTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Mailbox format is not correct"];
        return;
    }
    [self provied];
}

-(void)provied{
    [[ShareWork sharedManager]checkWithPhone:_emailTextfield.text type:@"modifypassword" complete:^(BaseModel *model) {
        
        if ([model.retCode isEqualToString:@"0000"]) {
            _achieveString = model.totalrecords;
            _codeNumber = model.content;
            [self timeout];
        }
        
        [[AppUtil appTopViewController] showHint:model.retDesc];
        
    }];
    
    
}


- (void)timeout
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);     dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //                _vercationBtn.titleLabel.font = [UIFont systemFontOfSize:18  ];
                //                [_vercationBtn setTitle:NSLocalizedString(@"regist_getcode", nil) forState:UIControlStateNormal];
                //                _vercationBtn.userInteractionEnabled = YES;
                //                _vercationBtn.backgroundColor = GREEN_COLOR;
                //                [_vercationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _codeBtn.backgroundColor = YELLOW_COLOR;
                [_codeBtn setTitle:@"Send Code" forState:UIControlStateNormal];
                _codeBtn.userInteractionEnabled = YES;
                [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
            });
        }else{
            // int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //  [UIView beginAnimations:nil context:nil];
                // [UIView setAnimationDuration:1];
                //                _vercationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                //                [_vercationBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [_vercationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //                [UIView commitAnimations];
                //
                //                _vercationBtn.userInteractionEnabled = NO;
                //                _vercationBtn.backgroundColor = [UIColor whiteColor];
                [_codeBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                [_codeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                _codeBtn.userInteractionEnabled = NO;
                _codeBtn.backgroundColor = LIGHT_GRAY_COLOR;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

-(void)regiestButtonTouch{
    if ([AppUtil isBlankString:_emailTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter your email"];
        return;
    }
    if (![AppUtil isValidateEmail:_emailTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Mailbox format is not correct"];
        return;
    }
    if ([AppUtil isBlankString:_codeTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter the verification code"];
        return;
    }
    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter password"];
        return;
    }
    
    if (_passwordTextfield.text.length<6) {
        [[AppUtil appTopViewController] showHint:@"Password at least 6 digits"];
        return;
        
        
    }
    
    if (![_emailTextfield.text isEqualToString:_achieveString]) {
        [[AppUtil appTopViewController] showHint:@"Please enter the correct verification code"];
        return;
    }
    if (![_codeTextfield.text isEqualToString:_codeNumber]) {
        [[AppUtil appTopViewController] showHint:@"Please enter the correct verification code"];
        return;
    }
    if (![_passwordTextfield.text isEqualToString:_surePasswordfield.text]) {
        [[AppUtil appTopViewController] showHint:@"password do not match"];
        return;
    }
    
    [self showHudInView:self.view hint:@"Is Submitting..."];
    [[ShareWork sharedManager]resetPasswordWith:_emailTextfield.text password:_passwordTextfield.text complete:^(BaseModel *model) {
        [self hideHud];
        [[AppUtil appTopViewController] showHint:model.retDesc];
        if (model) {

            [self.navigationController popViewControllerAnimated:NO];
        }
        
        
    }];
    
    
    
    
    
    
}
@end
