//
//  FeedViewController.m
//  petcamera
//
//  Created by yulei on 17/2/9.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedSetingTableViewCell.h"
#import "ShareWork+feed.h"
#import "FeedModel.h"

static NSString * cellId = @"fedseting2321232322313323231";

@interface FeedViewController ()
{
    
    NSArray * arrWord;
    
}

@end

@implementation FeedViewController
@synthesize bigBtn; // 喂食盘
@synthesize oneDayButton; // 一个
@synthesize twoDayButton; // 第二个
@synthesize StopBtn; // 停止
@synthesize bgViewTwo; // 两顿的背景
@synthesize bgViewOne; // 四顿的背景
@synthesize timeBtn1;
@synthesize timeBtn2;
@synthesize timeBtn3;
@synthesize timeBtn4;
@synthesize timeBtn5;
@synthesize timeBtn6;
@synthesize RbgImage;
@synthesize bigButton; // 时间








- (void)viewDidLoad {
    [super viewDidLoad];
    _sourceDic = [[NSDictionary alloc]init];
    _ondedayArray = [[NSMutableArray alloc]init];
    [self setNavTitle:NSLocalizedString(@"feed_model", nil)];
    _dataArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = LIGHT_GRAYdcdc_COLOR;
    arrWord =@[@"A",@"B",@"C",@"D"];
    [self onedayView];
    [self twoDayView];
    [self querWeishi];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}




-(void)setupView{
    [super setupView];
    
    // 圆圈背景
    RbgImage = [UIView new];
    RbgImage.backgroundColor = [UIColor whiteColor];
    RbgImage.layer.borderColor =RED_COLOR.CGColor;
    RbgImage.layer.borderWidth =0.7;
    [self.view addSubview:RbgImage];
    
    [RbgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(350);
        make.width.equalTo(self.view.mas_width);
        
        
    }];
    
    
    
    // 圆盘
    bigBtn =[UIButton new];
    [bigBtn setImage:[UIImage imageNamed:@"feed_pan"] forState:UIControlStateNormal];
    bigBtn.layer.cornerRadius = bigBtn.width/2;
    [self.view addSubview:bigBtn];
    
    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(204, 204));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
        
        
        
    }];
    
    

    // 方式
    UILabel * wenziLabel = [UILabel new];
    wenziLabel.text = NSLocalizedString(@"feed_way", nil);
    wenziLabel.textColor =YELLOW_COLOR;
    wenziLabel.font = [UIFont systemFontOfSize:20];
    [RbgImage addSubview:wenziLabel];
    [wenziLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(100, 28));
        make.bottom.equalTo(RbgImage.mas_bottom).offset(-10);
        
    }];
    
    
    
    
    // 两个圆圈
    
    
    oneDayButton =[UIButton new];
    oneDayButton.selected = YES;
    [oneDayButton setImage:[UIImage imageNamed:@"feed_r"] forState:UIControlStateNormal];
    
    [oneDayButton addTarget:self action:@selector(onedayButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [oneDayButton setImage:[UIImage imageNamed:@"feed_s"] forState:UIControlStateSelected];
    [RbgImage  addSubview:oneDayButton];
    [oneDayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_centerX).offset(30);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.top.equalTo(bigBtn.mas_bottom).offset(37);
        
    }];
    
    
    // 第一个圈文字
    

    UILabel * wenzi1 =[UILabel new];
    wenzi1.text = NSLocalizedString(@"feed_two", nil);
    wenzi1.textColor = YELLOW_COLOR;
    wenzi1.font = [UIFont systemFontOfSize:20];
    [RbgImage addSubview:wenzi1];
    [wenzi1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneDayButton.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.top.equalTo(bigBtn.mas_bottom).offset(32);
        
    }];
    
    
     // 第二个

    twoDayButton = [UIButton new];
    [twoDayButton setImage:[UIImage imageNamed:@"feed_r"] forState:UIControlStateNormal];
    [twoDayButton setImage:[UIImage imageNamed:@"feed_s"] forState:UIControlStateSelected];
    [twoDayButton addTarget:self action:@selector(twoDayButtontouch) forControlEvents:UIControlEventTouchUpInside];
    [RbgImage addSubview:twoDayButton];
    
    [twoDayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wenzi1.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.top.equalTo(bigBtn.mas_bottom).offset(37);
        
    }];
    // 第二个文字
    UILabel * wenzi2 =[UILabel new];
    wenzi2.text = NSLocalizedString(@"feed_four", nil);
    wenzi2.textColor = YELLOW_COLOR;
    wenzi2.font = [UIFont systemFontOfSize:20];
    [RbgImage addSubview:wenzi2];
    
    [wenzi2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoDayButton.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.top.equalTo(bigBtn.mas_bottom).offset(32);
        
    }];
    _isOneOrTwo = YES;
    // 下面tab bar
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomview.superview);
        make.right.equalTo(bottomview.superview);
        make.bottom.equalTo(bottomview.superview);
        make.height.mas_equalTo(50);
        
    }];
    
    StopBtn= [UIButton new];
    [StopBtn setTitle:NSLocalizedString(@"feed_stop", nil) forState:UIControlStateNormal];
    [StopBtn setTitleColor:RGB(220, 220, 220) forState:UIControlStateNormal];
    StopBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [StopBtn addTarget:self action:@selector(StopFeed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:StopBtn];
    [StopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(StopBtn.superview).offset(79);
        make.centerY.equalTo(StopBtn.superview.mas_centerY);
        
    }];
    
    
    
    
    UIButton * sureBtn = [UIButton new];
    [sureBtn setTitle:NSLocalizedString(@"feed_start", nil) forState:UIControlStateNormal];
    [sureBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureBtn addTarget:self action:@selector(StartFeed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sureBtn.superview).offset(-79);
        make.centerY.equalTo(sureBtn.superview.mas_centerY);
        
    }];
}

// 停止喂食
-(void)StopFeed:(UIButton *)sender{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", nil) message:NSLocalizedString(@"feed_surefeed", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure_bind_feed", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  FeddingModel * model = self.dataSource[0];
        NSString * str  =  [Defaluts objectForKey:@"deviceNumber"];
        NSString * str1  =Mid_D;
        NSString * deviceNum = str.length>str1.length?str:str1;
        
        NSString * str3 = [Defaluts objectForKey:@"termid"];
        NSString * str4 = Mid_T;
        NSString * termidstr = str3.length>str4.length?str3:str4;
        [self showHudInView:self.view hint:NSLocalizedString(@"feed_stoping", nil)];
        [[ShareWork sharedManager]cancelFeedingtimeWithbrid:_sourceDic[@"brid"] deviceno:deviceNum termid:termidstr complete:^(BaseModel *model) {
            [self hideHud];
            if (model) {
                [[AppUtil appTopViewController] showHint:model.retDesc];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel_bind", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)twoDayView{
   
    //两顿背景
    bgViewTwo = [UIView new ];
    bgViewTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgViewTwo];
    [bgViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(350);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(120);
        
        
        
                          
    }];
    
   
    
    // A B
    for (int i = 0 ; i < 2; i++) {
        
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(12 * W_Wide_Zoom, 59 * W_Hight_Zoom + i * 60 * W_Hight_Zoom, 351 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = LIGHT_GRAYdcdc_COLOR;
        [bgViewTwo addSubview:lineLabel];
        
        UILabel * tLabel = [[UILabel alloc]initWithFrame:CGRectMake(12 * W_Wide_Zoom, 15 * W_Hight_Zoom + i*60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        tLabel.text = arrWord[i];
        tLabel.textColor = YELLOW_COLOR;
        tLabel.font = [UIFont systemFontOfSize:20];
        [bgViewTwo addSubview:tLabel];
    }
    
    
    
    timeBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(290 * W_Wide_Zoom, 15 * W_Hight_Zoom, 80 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [timeBtn5 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn5 setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    timeBtn5.titleLabel.font = [UIFont systemFontOfSize:20];
    [bgViewTwo addSubview:timeBtn5];
    timeBtn5.tag = 15;
    [timeBtn5 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    
    timeBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(290 * W_Wide_Zoom, 75 * W_Hight_Zoom, 80 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [timeBtn6 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn6 setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    timeBtn6.titleLabel.font = [UIFont systemFontOfSize:20];
    [bgViewTwo addSubview:timeBtn6];
    timeBtn6.tag = 16;
    [timeBtn6 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)onedayView{
   
     bgViewOne = [UIView new];
     bgViewOne.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:bgViewOne];
    
    [bgViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(350);
       
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(240);
        
    }];
    for ( int i = 0; i<4; i++) {
        UIButton * btn =[UIButton new];
        btn.tag = 11+i;
        [btn setTitle:@"00:00" forState:UIControlStateNormal];
        [btn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
        [bgViewOne addSubview:btn];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(12 * W_Wide_Zoom, 59 * W_Hight_Zoom + i * 60 * W_Hight_Zoom, 351 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = LIGHT_GRAYdcdc_COLOR;
        [bgViewOne addSubview:lineLabel];
        
        UILabel * tLabel = [[UILabel alloc]initWithFrame:CGRectMake(12 * W_Wide_Zoom, 15 * W_Hight_Zoom + i*60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        tLabel.text = arrWord[i];
        tLabel.textColor = YELLOW_COLOR;
        tLabel.font = [UIFont systemFontOfSize:20];
        [bgViewOne addSubview:tLabel];
    }
     timeBtn1 = [self.view viewWithTag:11];
     timeBtn2 = [self.view viewWithTag:12];
     timeBtn3 = [self.view viewWithTag:13];
     timeBtn4 = [self.view viewWithTag:14];
     NSArray * OneArrlist =@[timeBtn1,timeBtn2,timeBtn3,timeBtn4];
    [OneArrlist mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view.mas_right).offset(-15);
        
    
    }];
    [OneArrlist mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:50 leadSpacing:18 tailSpacing:18];


}
-(void)hehedada:(UIButton *)sender{
    
    if (sender.tag == 11) {
        _panduanStr = @"11";
    }else if (sender.tag == 12){
        _panduanStr = @"12";
    }else if (sender.tag == 13){
        _panduanStr = @"13";
    }else if (sender.tag == 14){
        _panduanStr = @"14";
    }else if (sender.tag == 15){
        _panduanStr = @"15";
    }else if (sender.tag == 16){
        _panduanStr = @"16";
    }
    
    [self brithdayButtontouch];
}



-(void)brithdayButtontouch{
    bigButton = [[UIButton alloc]initWithFrame:self.view.bounds];
    bigButton.backgroundColor = [UIColor whiteColor];
    bigButton.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:bigButton];
    [bigButton addTarget:self action:@selector(bigButtonHidden) forControlEvents:UIControlEventTouchUpInside];
    
    _datePicker = [[ UIDatePicker alloc] initWithFrame:CGRectMake(0 * W_Wide_Zoom,200,self.view.frame.size.width,260 * W_Hight_Zoom)];
    _datePicker.datePickerMode = UIDatePickerModeTime;
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.alpha = 1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_datePicker];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置   为中文显示
    _datePicker.locale = locale;
    
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    _wanchengBtn = [[UIButton alloc]initWithFrame:CGRectMake(0* W_Wide_Zoom, 427 * W_Hight_Zoom, 375 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    _wanchengBtn.backgroundColor = [UIColor whiteColor];
    [_wanchengBtn setTitle:NSLocalizedString(@"feed_over", nil) forState:UIControlStateNormal];
    [_wanchengBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:_wanchengBtn];
    [_wanchengBtn addTarget:self action:@selector(wanchengButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)wanchengButtonTouch:(UIButton *)sender{
    
    NSDate *pickerDate = [_datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    //  NSInteger i = (NSInteger)dateString;
    if ([_panduanStr isEqualToString:@"11"]) {
        [timeBtn1 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"12"]){
        [timeBtn2 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"13"]){
        [timeBtn3 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"14"]){
        [timeBtn4 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"15"]){
        [timeBtn5 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"16"]){
        [timeBtn6 setTitle:dateString forState:UIControlStateNormal];
    }
    sender.hidden = YES;
    bigButton.hidden = YES;
    _datePicker.hidden = YES;
}




-(void)dateChanged:(id)sender{
    NSDate *pickerDate = [sender date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    if ([_panduanStr isEqualToString:@"11"]) {
        [timeBtn1 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"12"]){
        [timeBtn2 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"13"]){
        [timeBtn3 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"14"]){
        [timeBtn4 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"15"]){
        [timeBtn5 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"16"]){
        [timeBtn6 setTitle:dateString forState:UIControlStateNormal];
    }
   
}

-(void)bigButtonHidden{
    _wanchengBtn.hidden = YES;
    bigButton.hidden = YES;
    _datePicker.hidden = YES;
    
}

-(void)onedayButtonTouch{
    oneDayButton.selected = YES;
    twoDayButton.selected = NO;
    _isOneOrTwo = YES;
    bgViewTwo.hidden = NO;
    bgViewOne.hidden = YES;

}

-(void)twoDayButtontouch{
    bgViewOne.hidden = NO;
    bgViewTwo.hidden = YES;
    oneDayButton.selected = NO;
    twoDayButton.selected = YES;
    _isOneOrTwo = NO;
}
// 激活喂食
-(void)StartFeed:(UIButton *)sender{
    NSString * typeStr = @"";
    if (_isOneOrTwo == YES) {
        
        [_dataArray addObject:timeBtn5.titleLabel.text];
        [_dataArray addObject:timeBtn6.titleLabel.text];
        typeStr = @"two";
    }else{
        [_dataArray removeAllObjects];
        [_dataArray removeAllObjects];
        [_dataArray addObject:timeBtn1.titleLabel.text];
        [_dataArray addObject:timeBtn2.titleLabel.text];
        [_dataArray addObject:timeBtn3.titleLabel.text];
        [_dataArray addObject:timeBtn4.titleLabel.text];
        typeStr = @"one";
    }
    
    for (int i = 0 ; i < _dataArray.count - 1; i++) {
        for (int j = i + 1; j < _dataArray.count; j++) {
            if (_dataArray[i] == _dataArray[j]) {
                [[AppUtil appTopViewController] showHint:NSLocalizedString(@"feed_tips", nil)];
                return;
            }
        }
    }
    [self showHudInView:self.view hint:NSLocalizedString(@"feed_setting", nil)];
    NSString * timeStr = [_dataArray componentsJoinedByString:@","];
    NSString * termidStr =Mid_T ;
    NSString * deviceno = Mid_D;
    if ([AppUtil isBlankString:termidStr]) {
        NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
        deviceno = [defaults objectForKey:@"deviceNumber"];
        termidStr= [defaults objectForKey:@"termid"];
    }
    
    [[ShareWork sharedManager]addFeedingtimeWithMid:Mid_S type:typeStr times:timeStr deviceno:Mid_D termid:Mid_T complete:^(BaseModel *model) {
        [self hideHud];
        if (model) {
            [[AppUtil appTopViewController] showHint:model.retDesc];
            [self querWeishi];
        }
        
    }];
    NSLog(@"%@",_dataArray);
}

//查询
-(void)querWeishi{
    [timeBtn1 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn2 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn3 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn4 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn5 setTitle:@"00:00" forState:UIControlStateNormal];
    [timeBtn6 setTitle:@"00:00" forState:UIControlStateNormal];
    [self.dataSource removeAllObjects];
    [[ShareWork sharedManager]queryFeedingtimeWithMid:Mid_S status:@"1" complete:^(BaseModel *model) {
        if (model.list.count > 0 ) {
            [StopBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
            StopBtn.userInteractionEnabled = YES;
            _sourceDic = model.list[0];
            NSArray * array = [model.list[0][@"times"] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            if ([model.list[0][@"type"] isEqualToString:@"one"]) {
                oneDayButton.selected = NO;
                twoDayButton.selected = YES;
                _isOneOrTwo = NO;
                _moveView.frame = CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
                bgViewOne.hidden = NO;
                bgViewTwo.hidden = YES;
                [timeBtn1 setTitle:array[0] forState:UIControlStateNormal];
                [timeBtn2 setTitle:array[1] forState:UIControlStateNormal];
                [timeBtn3 setTitle:array[2] forState:UIControlStateNormal];
                [timeBtn4 setTitle:array[3] forState:UIControlStateNormal];
            }else{
                oneDayButton.selected = YES;
                twoDayButton.selected = NO;
                _isOneOrTwo = YES;
                _moveView.frame = CGRectMake(42 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
                bgViewOne.hidden = YES;
                bgViewTwo.hidden = NO;
                [timeBtn5 setTitle:array[0] forState:UIControlStateNormal];
                [timeBtn6 setTitle:array[1] forState:UIControlStateNormal];
                
            }
            
        }else{
            StopBtn.userInteractionEnabled = NO;
            oneDayButton.selected = NO;
            twoDayButton.selected = YES;
            _isOneOrTwo = NO;
            _moveView.frame = CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
        }
    }];
    
    
}


@end
