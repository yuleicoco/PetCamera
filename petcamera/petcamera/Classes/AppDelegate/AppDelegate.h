//
//  AppDelegate.h
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MainTabViewController* mainTabVC;
@property (nonatomic, strong) LoginViewController *loginVC;

@end

