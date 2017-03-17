//
//  InCallViewController.m
//  petcamera
//
//  Created by yulei on 17/2/8.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "InCallViewController.h"
#import "HWWeakTimer.h"
#import "ShareWork+Incall.h"
#import "BindingViewController.h"

#define TARGET 0
#define DELTE_SCALE 16
#define MAX_MOVE 200

@import CoreTelephony;

@interface InCallViewController ()

{
    NSTimer *updateTimer;
    NSTimer *hideControlsTimer;
    NSTimer * moveTimer;
    NSTimer * timeShow;
    
    UIButton * topBtn;
    UIButton * downBtn;
    UIButton * leftBtn;
    UIButton * rightBtn;
    
    BOOL isOPen;
    
    
    
    
    int timeCompar;
    int doubleTime;
    int couunt;
    
    // 投食次数
    NSInteger feeding;
    
    // 自己
    NSString * termidSelf;
    NSString * deviceoSelf;
    
    
    // 横屏
    int _deltaX;
    int _deltaY;
    int _lastMoveX;
    int _lastMoveY;
    int _currentX;
    int _currentY;
    
    int _startX;
    int _startY;
    
    NSArray * btnList;
    //方向键
    NSArray * DriArr;
    BOOL isPull;
    
  
    
    
    
}
@property (nonatomic, strong) CTCallCenter * center;
@property (nonatomic, assign) SephoneCall *call;
@end

@implementation InCallViewController
@synthesize call;
@synthesize videoView;
@synthesize btnBack;
@synthesize flowUI;
@synthesize FiveView;
@synthesize pointTouch;
@synthesize timeLable;
@synthesize pullBtn;
@synthesize Lcoin;
@synthesize Scoin;
@synthesize pullSbtn;








- (void)setCall:(SephoneCall *)acall {
    call = acall;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdateEvent:) name:kSephoneCallUpdate object:nil];
    
    // Update on show
    SephoneCall *call_ = sephone_core_get_current_call([SephoneManager getLc]);
    SephoneCallState state = (call != NULL) ? sephone_call_get_state(call_) : 0;
    [self callUpdate:call_ state:state animated:FALSE];
    // 视频
    sephone_core_set_native_video_window_id([SephoneManager getLc], (unsigned long)videoView);
    [flowUI startAnimating];
    // 创建定时器更新通话时间 (以及创建时间显示)
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateViews) userInfo:nil repeats:YES];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // [[UIApplication sharedApplication].keyWindow addSubview:self.backBtn];
    
    
    isPull = YES;
    
    self.center = [[CTCallCenter alloc] init];
    __weak InCallViewController *weakSelf = self;
    self.center.callEventHandler = ^(CTCall * call)
    {
        //TODO:检测到来电后的处理
        [weakSelf performSelectorOnMainThread:@selector(RefreshCellForLiveId)
                                   withObject:nil
                                waitUntilDone:NO];
        
        
    };
    
    
    // 后台
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillResignActive:)name:UIApplicationWillResignActiveNotification
                                              object:[UIApplication sharedApplication]];
    
    [self callStream:call];
    
}



// 初始化控件



- (void)setupView
{
    [super setupView];
    
    [self dowithID];
    isOPen = YES;
    // 视频界面
    videoView =[UIView new];
    videoView.backgroundColor =[UIColor blackColor];
    [self.view addSubview:videoView];
    
    // 等待状态
    flowUI  =[UIActivityIndicatorView new];
    flowUI.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [videoView addSubview:flowUI];
    
    [flowUI mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.size.mas_equalTo(CGSizeMake(45, 45));
        make.center.mas_equalTo(videoView.center);
        
    }];
    
    
    // 点
    pointTouch =[UIImageView new];
    [pointTouch setImage:[UIImage imageNamed:@"penSelect"]];
    
    
    //屏幕尺寸
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat width = size_screen.width;
    CGFloat height = size_screen.height;
    
    // 屏幕分成16份
    _deltaX = (int) (width / DELTE_SCALE);
    _deltaY = (int) (height / DELTE_SCALE);
    //  只需要得到滑动的最后一个点就OK
    
    _lastMoveX = -1;
    _lastMoveY = -1;
    
    [self.view addSubview:pointTouch];
    
    // 返回按钮
    btnBack =[UIButton new];
    [btnBack addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setImage:[UIImage imageNamed:@"close_down"] forState:UIControlStateNormal];
    [self.view addSubview:btnBack];
    
    
    // 时间
    timeLable =[UILabel new];
    timeLable.textColor =[UIColor whiteColor];
    timeLable.font =[UIFont systemFontOfSize:21];
    [self.view addSubview:timeLable];
    

    
    // 大圆小圆
    Lcoin =[UIImageView new];
    Lcoin.userInteractionEnabled = YES;
    Lcoin.image =[UIImage imageNamed:@"L_coin"];
    [self.view addSubview:Lcoin];
    
    Scoin =[UIButton new];
    [Scoin setImage:[UIImage imageNamed:@"S_coin"] forState:UIControlStateNormal];
    [Scoin addTarget:self action:@selector(changeAn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Scoin];
    
    
    
    
    // 5个按钮背景
    FiveView =[UIImageView new];
    FiveView.userInteractionEnabled = YES;
    [self.view addSubview:FiveView];
    
    
    // 方向键
     topBtn   =[UIButton new];
     downBtn =[UIButton new] ;
     leftBtn  =[UIButton new];
     rightBtn = [UIButton new];
     topBtn.tag =1000001;
     downBtn.tag=1000002;
     leftBtn.tag =1000003;
     rightBtn.tag =1000004;

    
    
    [topBtn addTarget:self action:@selector(topClickSt:) forControlEvents:UIControlEventTouchUpInside];
    [topBtn addTarget:self action:@selector(Stopclick:) forControlEvents:UIControlEventTouchDown];
    
    
    [downBtn addTarget:self action:@selector(downClickSt:) forControlEvents:UIControlEventTouchUpInside];
    [downBtn addTarget:self action:@selector(Sdownclick:) forControlEvents:UIControlEventTouchDown];
    
    [leftBtn addTarget:self action:@selector(leftClickSt:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn addTarget:self action:@selector(Sleftclick:) forControlEvents:UIControlEventTouchDown];
    
    
    [rightBtn addTarget:self action:@selector(rightClickSt:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(Srightclick:) forControlEvents:UIControlEventTouchDown];
    
    
    DriArr =@[topBtn,downBtn,leftBtn,rightBtn];
    for (NSInteger i =0; i<4; i++) {
        [Lcoin addSubview:DriArr[i]];
        
        
    }
    

    // 推拉
    pullBtn =[UIButton new];
    pullBtn.userInteractionEnabled = YES;
    [pullBtn setImage:[UIImage imageNamed:@"take_off"] forState:UIControlStateNormal];
    [pullBtn addTarget:self action:@selector(pullBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pullBtn];
    
    pullSbtn =[UIButton new];
    [pullSbtn setImage:[UIImage imageNamed:@"take_on"] forState:UIControlStateNormal];
    pullSbtn.hidden = YES;
    [pullSbtn addTarget:self action:@selector(pullBtnS:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pullSbtn];
    
    
    
    
    
    // 5个按钮
    UIButton * lightbtn =[UIButton new];
    UIButton * foodbtn =[UIButton new];
    UIButton * rollbtn =[UIButton new];
    UIButton * takephoto =[UIButton new];
    
    
    [lightbtn addTarget:self action:@selector(LightClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [foodbtn addTarget:self action:@selector(RollClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rollbtn addTarget:self action:@selector(FoodClick:) forControlEvents:UIControlEventTouchUpInside];
    [takephoto addTarget:self action:@selector(PhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btnList =@[lightbtn,foodbtn,rollbtn,takephoto];
    for (NSInteger i =0; i<4; i++) {
        
        [FiveView addSubview:btnList[i]];
    }
    
    
    [self HviewUpdateView];
    
    
    
}



// 横屏激光笔

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    //触摸对象的位置
    CGPoint previousPoint = [touch locationInView:self.view.window];
    
    _startX = (int)previousPoint.x;
    _startY = (int)previousPoint.y;
    
    pointTouch.frame = CGRectMake(previousPoint.x - TARGET/2,previousPoint.y -TARGET/2, TARGET, TARGET);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    //获取任意一个触摸对象
    UITouch *touch = [touches anyObject];
    
    //触摸对象的位置
    CGPoint previousPoint = [touch locationInView:self.view.window];
    int currentX = (int)previousPoint.x;
    int currentY = (int)previousPoint.y;
    
    pointTouch.frame = CGRectMake(previousPoint.x - TARGET/2,(previousPoint.y - TARGET/2), TARGET, TARGET);
    int changeX = 0; //转换的x 不超过90
    int changeY = 0; //转换的y 不超过90
    
    //屏幕尺寸
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat width = size_screen.width;
    CGFloat height = size_screen.height;
    
    
    changeX = (int) ((MAX_MOVE / width) * currentX);
    changeY = (int) ((MAX_MOVE / height) * currentY);
    changeX = MAX_MOVE- changeX;
    changeY = MAX_MOVE- changeY;
   
    NSString * msg =[NSString stringWithFormat:@"control_pantilt,0,0,1,0,%d,%d",changeX,changeY];
    [self sendMessage:msg];
    
    
    
}

// 结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    
}





-(void) sendMoveCommand:(int) sendX withY:(int) sendY{
    
    
    int changeX = 0; //转换的x 不超过90
    int changeY = 0; //转换的y 不超过90
    
    //屏幕尺寸
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat width = size_screen.width;
    CGFloat height = size_screen.height;
    
    
    changeX = (int) ((MAX_MOVE / width) * sendX);
    changeY = (int) ((MAX_MOVE / height) * sendY);
    changeY = MAX_MOVE- changeY;
    
    
    NSLog(@"sendMoveCommand:changeX=%d,changeY=%d, deltaX=%d, deltaY=%d,x=%d,y=%d, sX=%d ,sY=%d, sendCX=%d, sendCY=%d" ,changeX ,changeY ,_deltaX , _deltaY, sendX ,sendY,(MAX_MOVE-changeY), (MAX_MOVE-changeX), (int)((MAX_MOVE-changeY)*1.35), (int)((MAX_MOVE-changeX)*1.35));
    
    
}



//  返回
- (void)backBtn:(UIButton *)sender {
    [self videoEnd];
    [updateTimer invalidate];
    [SephoneManager terminateCurrentCallOrConference];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/**
 *   横屏的切换 约束更新
 */
- (void)HviewUpdateView
{
    
    videoView.transform = CGAffineTransformScale(self.videoView.transform, 1.32, 1.04);
    
    // 视频界面
    [videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.top.mas_equalTo(0);
        
    }];
    [btnBack mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(12);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        
    }];
    
    // 横屏红外线
    [pointTouch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(TARGET);
        
    }];
    
    
    
    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(65, 40));
        
    }];
    

    FiveView.image =[UIImage imageNamed:@"halfAp"];
    FiveView.backgroundColor =[UIColor clearColor];
    FiveView.layer.borderWidth =0;
    
    // 5个按钮背景
    [FiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(83);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.bottom.mas_offset(-40);
        make.right.equalTo(self.view.mas_right);
        
        
        
    }];
    
    // 5个按钮
    NSArray * imageListS=@[@"v_light",@"v_rool",@"v_feed",@"v_photo"];
    NSArray * imageListN=@[@"v_light_n",@"v_rool_n",@"v_feed_n",@"v_photo_n"];
    for (NSInteger i =0; i<4; i++) {
        [btnList[i] setImage:[UIImage imageNamed:imageListN[i]] forState:UIControlStateNormal];
        [btnList[i] setImage:[UIImage imageNamed:imageListS[i]] forState:UIControlStateSelected];
    }
    
    
    
    
    
    
    // 推拉
    [pullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(FiveView.mas_left).offset(6);
        make.size.mas_equalTo(CGSizeMake(15, 22));
        make.bottom.equalTo(self.view.mas_bottom).offset(-184);
        
        
    }];
    
    [pullSbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(15, 22));
        make.bottom.equalTo(self.view.mas_bottom).offset(-184);
        
        
    }];
    
    
    
    
    
   
    
    NSArray * imageList =@[@"v_up",@"v_down",@"v_left",@"v_right"];
    
    for (NSInteger i =0; i<4; i++) {
        [DriArr[i] setImage:[UIImage imageNamed:imageList[i]] forState:UIControlStateNormal];
        
    }
    
    
    [btnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FiveView.mas_left).offset(28);
        make.right.equalTo(self.view.mas_right).offset(-13);
        make.height.mas_equalTo(50);
        
        
        
        
    }];
    
    /**
     *  axisType         轴线方向
     *  fixedSpacing     间隔大小
     *  fixedItemLength  每个控件的固定长度/宽度
     *  leadSpacing      头部间隔
     *  tailSpacing      尾部间隔
     *
     */
    
    // 50 22 22
    
    [btnList mas_distributeViewsAlongAxis:MASAxisTypeVertical
                      withFixedItemLength:50 leadSpacing:20 tailSpacing:20];
    
    
    
    
    
    // 大圆小圆
    [Lcoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(148, 148));
        make.left.equalTo(self.view.mas_left).offset(16);
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
        
        
    }];
    
    
    [Scoin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(41, 41));
        make.centerX.equalTo(Lcoin.mas_centerX);
        make.centerY.equalTo(Lcoin.mas_centerY);
        
        
    }];
    
    
    //方向按钮
    
    [DriArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-124);
        make.size.mas_equalTo(CGSizeMake(79*0.75,79*0.75));
        make.centerX.equalTo(Lcoin.mas_centerX);

        
        
        
        
    }];
    
    
    [DriArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-16);
        make.size.mas_equalTo(CGSizeMake(79*0.75,79*0.75));
        make.centerX.equalTo(Lcoin.mas_centerX);

        
        
        
    }];
    //左
    [DriArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(79*0.75,79*0.75));
        make.centerY.equalTo(Lcoin.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(14);
        
        
        
    }];
    
    [DriArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(Lcoin.mas_centerY);
          make.size.mas_equalTo(CGSizeMake(79*0.75,79*0.75));
          make.left.equalTo(self.view.mas_left).offset(114);

        
    }];
    
       
    
    
    
}


// 收回
- (void)changeAn:(UIButton *)sender
{
    
 
    
    if (isOPen) {
     
        isOPen = NO;
     [UIView animateWithDuration:0.5 animations:^{
       
         Lcoin.transform=CGAffineTransformMakeScale(0.1f, 0.1f);
        
        for (int i = 0; i<4; i ++) {
            
            [self.view viewWithTag:1000001+i].center = CGPointMake(74, 74);
            [self.view viewWithTag:1000001+i].transform = CGAffineTransformMakeScale(0.6f, 0.6f);
            
        }
        
    } completion:^(BOOL finished) {
        //平移结束
        
        return ;
        
    }];
    }else
    {
        Lcoin.transform=CGAffineTransformMakeScale(1.0f, 1.0f);

        isOPen = YES;
        [UIView animateWithDuration:0.5 animations:^{
           
            for (int i = 0; i<4; i ++) {
                
                if(i<2)
                {
                     leftBtn.center = CGPointMake(27.75, 74);
                     rightBtn.center = CGPointMake(127.75, 74);
                    
                }else{
                    topBtn.center = CGPointMake(74, 19.5);
                    downBtn.center =CGPointMake(74, 127.5);
                    
                }
                
                
                [self.view viewWithTag:1000001+i].transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                
            }
            
        } completion:^(BOOL finished) {
            //平移结束
            
            
            return ;
            
        }];
        
    

        
   }

    

    
    
}




#pragma mark  buttonMethod _________________各点击事件__________________________


//弹出 收回

- (void)pullBtn:(UIButton *)sender
{

        // 移动view
        FiveView.hidden = YES;
        pullBtn.hidden = YES;
        pullSbtn.hidden = NO;
    
}

- (void)pullBtnS:(UIButton *)sender
{
    
    // 移动view
    FiveView.hidden = NO;
    pullBtn.hidden = NO;
    pullSbtn.hidden = YES;
    
}






- (void)applicationWillResignActive:(NSNotification *)notification

{
    
    [self RefreshCellForLiveId];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    if (updateTimer != nil) {
        [updateTimer invalidate];
        updateTimer = nil;
    }
    
    [moveTimer invalidate];
    
    // Clear windows
    //  必须清除，否则会因为arc导致再次视频通话时crash。
    sephone_core_set_native_video_window_id([SephoneManager getLc], (unsigned long)NULL);
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSephoneCallUpdate object:nil];
}




- (void)RefreshCellForLiveId
{
    
    [SephoneManager terminateCurrentCallOrConference];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)callStream:(SephoneCall *)calls
{
    
    if (calls != NULL) {
        
        sephone_call_set_next_video_frame_decoded_callback(calls, hideSpinner, (__bridge void *)(self));
    }
    
    
    if (![SephoneManager hasCall:calls]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    
    
}


- (int )getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    int a =[[timeNow substringWithRange:NSMakeRange(0, 2)] intValue];
    int b =[[timeNow substringWithRange:NSMakeRange(3, 2)] intValue];
    int c=[[timeNow substringWithRange:NSMakeRange(6, 2)] intValue];
    int d =[[timeNow substringFromIndex:9]intValue];
    a= a*3600000+b*60000+c*1000+d;
    return a;
    
}




//**************************外设控制**************************//



#pragma sendMessageTest wjb
-(void) sendMessage:(NSString *)mess{
    
    const char * message =[mess UTF8String];
    sephone_core_send_user_message([SephoneManager getLc], message);
    
}



// 除了开灯其他的都延迟3秒

//喂食
- (void)FoodClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [[ShareWork sharedManager]feed:deviceoSelf ter:termidSelf complete:^(BaseModel *model) {
         sender.selected = !sender.selected;
        
    }];
    

    
    
}




/**
 *  开灯
 *
 *  @param sender  on  off
 */
- (void)LightClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSString * str1;
    doubleTime++;
    if (doubleTime%2 ==0) {
        str1 = @"off";
    }else
    {
        
        str1 =@"on";
    }
   [[ShareWork sharedManager]light:deviceoSelf ter:termidSelf action:str1 complete:^(BaseModel *model) {
       
   }];
    
    
    
}

// 零食
- (void)RollClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSString * selfID =[Defaluts objectForKey:@"selfID"];
    [[ShareWork sharedManager]roll:deviceoSelf ter:termidSelf num:selfID complete:^(BaseModel *model) {
        sender.selected = !sender.selected;
    }];
    

    
    
    
}

//抓拍
- (void)PhotoClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    

    
   [[ShareWork sharedManager]photo:deviceoSelf ter:termidSelf complete:^(BaseModel *model) {
       
       sender.selected = !sender.selected;

   }];
    

    
}


//4上 3下 2左 1右


// 上
- (void)Stopclick:(UIButton *)sender {
    
    [self moveRobot:@"4"];
    
    NSLog(@"上");
}

// 上结束
- (void)topClickSt:(UIButton *)sender {
    [self overTime];
}



// 下
- (void)downClickSt:(UIButton *)sender {
    
    [self overTime];
}

- (void)Sdownclick:(UIButton *)sender {
    
    [self moveRobot:@"3"];
    
    NSLog(@"下");
    
    
}




// 左
- (void)Sleftclick:(UIButton *)sender {
    
    [self moveRobot:@"2"];
     NSLog(@"左");
}

- (void)leftClickSt:(UIButton *)sender {
    
    [self overTime];
    
}

// 右
- (void)rightClickSt:(UIButton *)sender {
    
    [self overTime];
}
- (void)Srightclick:(UIButton *)sender {
    
    
    [self moveRobot:@"1"];
     NSLog(@"右");
    
}





- (void)moveRobot:(NSString *)str
{
    //4上 3下 2左 1右
    NSInteger i = [str integerValue];
    switch (i) {
        case 1:
            topBtn.userInteractionEnabled = NO;
            downBtn.userInteractionEnabled =NO;
            leftBtn.userInteractionEnabled =NO;
            rightBtn.userInteractionEnabled =YES;

            break;
            
        case 2:
           
            topBtn.userInteractionEnabled = NO;
            downBtn.userInteractionEnabled =NO;
            leftBtn.userInteractionEnabled =YES;
            rightBtn.userInteractionEnabled =NO;

            
            
            break;
        case 3:
           
            topBtn.userInteractionEnabled = NO;
            downBtn.userInteractionEnabled =YES;
            leftBtn.userInteractionEnabled =NO;
            rightBtn.userInteractionEnabled =NO;
            
            
            break;
        case 4:
            
            topBtn.userInteractionEnabled = YES;
            downBtn.userInteractionEnabled =NO;
            leftBtn.userInteractionEnabled =NO;
            rightBtn.userInteractionEnabled =NO;
            
           
            break;
            
        default:
            break;
    }
    
    if ((topBtn.userInteractionEnabled || downBtn.userInteractionEnabled)
        && (topBtn.userInteractionEnabled ||leftBtn.userInteractionEnabled)  && (topBtn.userInteractionEnabled ||rightBtn.userInteractionEnabled) && (downBtn.userInteractionEnabled ||rightBtn.userInteractionEnabled)&& (downBtn.userInteractionEnabled ||leftBtn.userInteractionEnabled) && (leftBtn.userInteractionEnabled ||rightBtn.userInteractionEnabled) ) {
        
        return;
    }
    
    
    moveTimer = [HWWeakTimer scheduledTimerWithTimeInterval:1.0*0.2 block:^(id userInfo) {
        
        [self sendInfomation:str];
    } userInfo:@"Fire" repeats:YES];
    [moveTimer fire];
}


- (void)sendInfomation:(NSString *)sender
{
    
    NSString * msg =[NSString stringWithFormat:@"control_servo,0,0,1,%d,200",[sender intValue]];
    [self sendMessage:msg];
    
    
}



- (void)overTime
{
    [moveTimer invalidate];
    topBtn.userInteractionEnabled = YES;
    downBtn.userInteractionEnabled =YES;
    leftBtn.userInteractionEnabled =YES;
    rightBtn.userInteractionEnabled =YES;
    
    
    
    
}

// 更新控件内容
- (void)updateViews {
    
    SephoneCall *calltime= sephone_core_get_current_call([SephoneManager getLc]);
    
    if (calltime == NULL) {
        return;
    }else
    {
        int duration = sephone_call_get_duration(calltime);
        
        //NSLog(@"=========时间======%02i:%02i",(duration/60), (duration%60));
        timeLable.text =[NSString stringWithFormat:@"%02i:%02i", (duration/60), (duration%60), nil];
        
        if (duration >= 300) {
            
            [SephoneManager terminateCurrentCallOrConference];
            NSLog(@"五分钟到时视频流自动断开");
            [self videoEnd];
            
        }
        
        
    }
    
}




// 通话监听

- (void)callUpdate:(SephoneCall *)call_ state:(SephoneCallState)state animated:(BOOL)animated {
    
    
    
    // Fake call update
    if (call_ == NULL) {
        return;
    }
    
    switch (state) {
            // 通话结束或出错时退出界面。
        case SephoneCallEnd:
        case SephoneCallError: {
            call = NULL;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}


- (void)callUpdateEvent:(NSNotification *)notif {
    SephoneCall *call_ = [[notif.userInfo objectForKey:@"call"] pointerValue];
    SephoneCallState state = [[notif.userInfo objectForKey:@"state"] intValue];
    [self callUpdate:call_ state:state animated:TRUE];
}



/**
 *  结束设备使用记录
 */


- (void)videoEnd
{
    
 
    NSString *  selfID =[Defaluts objectForKey:@"selfID"];
    [[ShareWork sharedManager]DeviceUse:selfID complete:^(BaseModel *model) {
        
    }];
    
}



- (void)dowithID
{
    
    NSString * devoLG =Mid_D;
    NSString * termidLG =Mid_T;
    NSString * devo  = [Defaluts objectForKey:PREF_DEVICE_NUMBER];
    NSString * termid = [Defaluts objectForKey:TERMID_DEVICNUMER];
    
    if ([AppUtil isBlankString:devoLG]) {
        if ([AppUtil isBlankString:devo]) {
            //没有设备
        }else{
            termidSelf = termid;
            deviceoSelf = devo;
        }
    }else{
        termidSelf = termidLG;
        deviceoSelf = devoLG;
        
        
    }
    

    
}


// 用户体验设置

- (void)hideSpinnerIndicator:(SephoneCall *)call {
    
    [flowUI stopAnimating];
    
    
    
}

static void hideSpinner(SephoneCall *call, void *user_data) {
    InCallViewController *thiz = (__bridge InCallViewController *)user_data;
    [thiz hideSpinnerIndicator:call];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 只允许横屏

-(BOOL)shouldAutorotate
{
    return NO;
    
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskLandscape;
}
@end
