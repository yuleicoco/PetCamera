//
//  InCallViewController.h
//  petcamera
//
//  Created by yulei on 17/2/8.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface InCallViewController : BaseViewController

- (void)setCall:(SephoneCall *)acall;
// 别人
@property (nonatomic,strong)UIView * videoView;
// 返回
@property (nonatomic,strong)UIButton * btnBack;
//等待
@property (nonatomic,strong)UIActivityIndicatorView * flowUI;

// 5个button背景
@property (nonatomic,strong)UIImageView * FiveView;
@property (nonatomic,strong)UIImageView * Lcoin;
@property (nonatomic,strong)UIButton *Scoin;
@property (nonatomic,strong)UIImageView * pointTouch;
@property (nonatomic,strong)UILabel * timeLable;
@property (nonatomic,strong)UIButton * pullBtn;
@property (nonatomic,strong)UIButton * pullSbtn;


@end
