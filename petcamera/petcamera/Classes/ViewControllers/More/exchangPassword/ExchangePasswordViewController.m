//
//  ExchangePasswordViewController.m
//  petcamera
//
//  Created by czx on 2017/2/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ExchangePasswordViewController.h"
#import "ShareWork+Login.h"

@interface ExchangePasswordViewController ()
@property (nonatomic,strong)UITextField * codeTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@property (nonatomic,strong)UITextField * surePasswordfield;
@end

@implementation ExchangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"Change Password"];
}

-(void)setupView{

    UIView * secoendView = [[UIView alloc]init];
    secoendView.backgroundColor = [UIColor whiteColor];
    secoendView.layer.borderColor = RED_COLOR.CGColor;
    secoendView.layer.borderWidth = 1;
    secoendView.layer.cornerRadius = 25;
    [self.view addSubview:secoendView];
    [secoendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secoendView.superview).offset(15);
        make.right.equalTo(secoendView.superview).offset(-15);
        make.top.equalTo(secoendView.superview).offset(10);
        make.height.mas_equalTo(50);
        
    }];
    
    _codeTextfield = [[UITextField alloc]init];
    _codeTextfield.tintColor = YELLOW_COLOR;
    _codeTextfield.textColor = YELLOW_COLOR;
    _codeTextfield.placeholder = @"Enter your old password";
    [_codeTextfield setValue:YELLOW_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    _codeTextfield.font = [UIFont systemFontOfSize:18];
    _codeTextfield.keyboardType = UIKeyboardTypeAlphabet;
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
    _surePasswordfield.keyboardType = UIKeyboardTypeAlphabet;
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
    [registBtn addTarget:self action:@selector(regiestButtonTouch313) forControlEvents:UIControlEventTouchUpInside];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registBtn.superview).offset(15);
        make.right.equalTo(registBtn.superview).offset(-15);
        make.top.equalTo(surepassView.mas_bottom).offset(25);
        make.height.mas_equalTo(50);
    }];


}

-(void)regiestButtonTouch313{
    if ([AppUtil isBlankString:_codeTextfield.text ]) {
        [[AppUtil appTopViewController] showHint:@"Please enter password"];
        return;
    }
    if (![[AccountManager sharedAccountManager].loginModel.password isEqualToString:_codeTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter the correct old password"];
        return;
    }
    

    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"Please enter the new  password"];
        return;

    }
    if (_passwordTextfield.text.length<6) {
        [[AppUtil appTopViewController] showHint:@"Password at least 6 digits"];
        return;

    }
    
    if (![_passwordTextfield.text isEqualToString:_surePasswordfield.text]) {
        [[AppUtil appTopViewController] showHint:@"password do not match"];
        return;
    }

//    [self showHudInView:self.view hint:@"Being modified..."];

    [[ShareWork sharedManager]modifyPasswordWithMid:[AccountManager sharedAccountManager].loginModel.mid password:_passwordTextfield.text complete:^(BaseModel *model) {
  //      [self hideHud];
        if (model) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Tips"message:@"Modify success, please login again" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Sure" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
                [[AccountManager sharedAccountManager]logout];
                
                NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
                NSString * incodeNumStr = [userDefatluts objectForKey:@"incodeNum"];
                
                NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
                for(NSString* key in [dictionary allKeys]){
                    [userDefatluts removeObjectForKey:key];
                    [userDefatluts synchronize];
                }
                [userDefatluts setObject:@"1" forKey:@"STARTFLAG"];
                [userDefatluts setObject:incodeNumStr forKey:@"incodeNum"];
            }];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [[AppUtil appTopViewController]showHint:model.retDesc];
        }
        
        
    }];
    
    
    
    

}




@end
