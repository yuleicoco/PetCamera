//
//  FeedViewController.h
//  petcamera
//
//  Created by yulei on 17/2/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "BaseTabViewController.h"

@interface FeedViewController : BaseTabViewController
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIButton * oneDayButton;
@property (nonatomic,strong)UIButton * twoDayButton;
@property (nonatomic,strong)UIView * moveView;
@property (nonatomic,assign)BOOL isOneOrTwo;

@property (nonatomic,strong)NSMutableArray * ondedayArray;
@property (nonatomic,strong)NSString * timeStr;


@property (nonatomic,strong)UIButton * timeBtn1;
@property (nonatomic,strong)UIButton * timeBtn2;
@property (nonatomic,strong)UIButton * timeBtn3;
@property (nonatomic,strong)UIButton * timeBtn4;
@property (nonatomic,strong)UIButton * timeBtn5;
@property (nonatomic,strong)UIButton * timeBtn6;



@property (nonatomic,strong)UIDatePicker * datePicker;
@property (nonatomic,strong)UIView * bigView;
@property (nonatomic,strong)UIButton * bigButton;
@property (nonatomic,strong)UIButton * wanchengBtn;
@property (nonatomic,strong)NSString * panduanStr;

@property (nonatomic,strong)NSMutableArray * dataArray;


@property (nonatomic,strong)UIView * bgViewOne;
@property (nonatomic,strong)UIView * bgViewTwo;

@property (nonatomic,strong)UIButton * StopBtn;
@property (nonatomic,strong)NSDictionary * sourceDic;
@property (nonatomic,strong)UIView * RbgImage;



@end

