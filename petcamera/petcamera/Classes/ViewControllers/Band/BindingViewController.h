//
//  BindingViewController.h
//  petcamera
//
//  Created by yulei on 17/2/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>




// 设置相关配置项
extern NSString *const PREF_DEVICE_NUMBER;
extern NSString *const PREF_WIFI_CONFIGURED;
extern NSString *const TERMID_DEVICNUMER;


// sego蓝牙配置服务常量
extern NSString *const SEGOPASS_BLE_DEVICE_NAME;
extern NSString *const CONFIG_SERVICE_UUID;
extern NSString *const REQUEST_CHARACTERISTIC_UUID;
extern NSString *const RESULT_CHARACTERISTIC_UUID;
extern NSString *const SEGOEGG_PREFIX;

@interface BindingViewController : BaseViewController<CBPeripheralManagerDelegate>


@property (nonatomic,strong) UITextField * deviceTF;
@property (nonatomic,strong)UITextField * incodeTF;
@property (nonatomic,strong)UIButton * btnBind;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong)NSString * strTT;



@end
