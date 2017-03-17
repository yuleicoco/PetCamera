//
//  ViewController.m
//  petcamera
//
//  Created by yulei on 16/12/17.
//  Copyright © 2016年 yulei. All rights reserved.
//

#import "ViewController.h"
#import "ShareWork+account.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSString * are1 =@"1040341999@qq.com";
    NSString * are2 =@"123456";
    are1 = [are1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];

    are2 = [are2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    // 网络请求
   [[ShareWork sharedManager]loginWithUserName:are1 password:are2 complete:^(BaseModel *model) {
       
       NSLog(@"%@",model);
       
       
   }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
