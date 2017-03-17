//
//  WifiViewController.h
//  petcamera
//
//  Created by yulei on 17/2/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseViewController.h"

@interface WifiViewController : BaseViewController
@property (nonatomic,strong)NSArray * listArr;
@property (nonatomic, weak) MBProgressHUD *hud;
@property (nonatomic,strong)NSString * strDevice;


@end

