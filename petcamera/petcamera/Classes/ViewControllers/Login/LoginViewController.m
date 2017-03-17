//
//  LoginViewController.m
//  petcamera
//
//  Created by czx on 2017/2/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "LoginViewController.h"
#import "RegiestViewController.h"
#import "CompleViewController.h"
#import "ShareWork+Login.h"
#import "LoginModel.h"

@interface LoginViewController ()
@property (nonatomic,strong)UITextField * accountTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
   
    
}
-(void)dowewerwfwafa{

    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];

}


-(void)setupView{
    UIImageView * backImage = [[UIImageView alloc]init];
    backImage.image = [UIImage imageNamed:@"loginBackkk.png"];
    [self.view addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(backImage.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];

    UIView * centerView = [[UIView alloc]init];
    centerView.backgroundColor = RGB(245, 145, 40);
    centerView.alpha = 0.8;
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.superview).offset(200);
        make.left.equalTo(centerView.superview).offset(20);
        make.right.equalTo(centerView.superview).offset(-20);
        make.bottom.equalTo(centerView.superview).offset(-200);
        
        
    }];
    
    UIView * topKuang = [[UIView alloc]init];
    topKuang.layer.borderColor = [UIColor whiteColor].CGColor;
    topKuang.layer.borderWidth = 1;
    topKuang.layer.cornerRadius = 25;
    [self.view addSubview:topKuang];
    [topKuang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_top).offset(40);
        make.left.equalTo(centerView.mas_left).offset(15);
        make.right.equalTo(centerView.mas_right).offset(-15);
        make.height.mas_equalTo(50);
        
    }];
    
    _accountTextfield = [[UITextField alloc]init];
    _accountTextfield.font = [UIFont systemFontOfSize:18];
    _accountTextfield.keyboardType = UIKeyboardTypeAlphabet;
    _accountTextfield.placeholder = @"EMAIL";
    _accountTextfield.tintColor = [UIColor whiteColor];
    _accountTextfield.textColor = [UIColor whiteColor];
    [_accountTextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_accountTextfield];
    [_accountTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topKuang.mas_left).offset(15);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(topKuang.mas_top);
        make.height.mas_equalTo(50);
        
    }];
    
    UIView * downKuang = [[UIView alloc]init];
    downKuang.layer.borderWidth = 1;
    downKuang.layer.borderColor = [UIColor whiteColor].CGColor;
    downKuang.layer.cornerRadius = 25;
    [self.view addSubview:downKuang];
    [downKuang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topKuang.mas_bottom).offset(15);
        make.left.equalTo(centerView.mas_left).offset(15);
        make.right.equalTo(centerView.mas_right).offset(-15);
        make.height.mas_equalTo(50);

        
    }];
    
    _passwordTextfield = [[UITextField alloc]init];
    _passwordTextfield.font = [UIFont systemFontOfSize:18];
    _passwordTextfield.tintColor = [UIColor whiteColor];
    _passwordTextfield.textColor = [UIColor whiteColor];
    _passwordTextfield.placeholder = @"PASSWORD";
    _passwordTextfield.keyboardType = UIKeyboardTypeAlphabet;
    [_passwordTextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_passwordTextfield];
    [_passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(downKuang.mas_left).offset(15);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(downKuang.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    UILabel * forgetLabel = [[UILabel alloc]init];
    forgetLabel.text = @"FORGOT PASSWORD?";
    forgetLabel.textColor = [UIColor whiteColor];
    forgetLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordTextfield.mas_left);
        make.top.equalTo(downKuang.mas_bottom).offset(15);
        

    }];
    
    UIButton * forgetBtn = [[UIButton alloc]init];
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn addTarget:self action:@selector(forgetButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(forgetLabel.mas_left);
        make.top.equalTo(forgetLabel.mas_top);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        
    }];
    
    UIButton * loginBtn = [[UIButton alloc]init];
    loginBtn.backgroundColor = [UIColor whiteColor];
    loginBtn.layer.cornerRadius = 18;
    [loginBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    [loginBtn setTitleColor:RGB(245, 145, 40) forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(centerView.mas_bottom).offset(-20);
        make.centerX.equalTo(centerView.mas_centerX);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(35);
        
    }];
    
    
    UIButton * signupBtn = [[UIButton alloc]init];
    signupBtn.backgroundColor = [UIColor clearColor];
    [signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [signupBtn setTitleColor:RGB(245, 145, 40) forState:UIControlStateNormal];
    signupBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [signupBtn addTarget:self action:@selector(regiestButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signupBtn];
    [signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(signupBtn.superview.mas_centerX);
        make.bottom.equalTo(signupBtn.superview.mas_bottom).offset(-50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
        
        
    }];

    
}

-(void)regiestButtonTouch{
    RegiestViewController * regiestVc = [[RegiestViewController  alloc]init];
    [self.navigationController pushViewController:regiestVc animated:NO];


}

-(void)forgetButtonTouch{
    CompleViewController * comVc = [[CompleViewController alloc]init];
    [self.navigationController pushViewController:comVc animated:NO];

}


-(void)loginButtonTouch{
    if ([AppUtil isBlankString:_accountTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter your email"];
        return;
    }
    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter your password"];
        return;
    }
     [self showHudInView:self.view hint:@"please wait..."];
    [[ShareWork sharedManager]memberLoginWithAccountnumber:_accountTextfield.text password:_passwordTextfield.text complete:^(BaseModel *model) {
        if ([model.retCode isEqualToString:@"0000"]) {
            LoginModel * loginModel = [[LoginModel alloc]initWithDictionary:model.list[0] error:nil];
            
            [[AccountManager sharedAccountManager]login:loginModel];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
            
            
        }else{
            [[AppUtil appTopViewController]showHint:model.retDesc];
            
        }
           [self hideHud];
    }];
    
    
    
    
    
    
    
    
    


}





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}


@end
