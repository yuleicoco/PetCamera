//
//  AppDelegate+Sephone.m
//  petegg
//
//  Created by yulei on 16/4/25.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AppDelegate+Sephone.h"

@implementation AppDelegate (Sephone)

- (void)initSephoneVoip:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //Sephone  单向无须做太多操作(考虑到以后)
    [[SephoneManager instance]	startSephoneCore];
     
    
   // 创建manger
  //  AFHTTPSessionManager * afmanger =[AFHTTPSessionManager manager];
   
    // 网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    
    
    
}
@end
