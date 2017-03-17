//
//  ReposinotuploadViewController.m
//  petcamera
//
//  Created by czx on 2017/2/13.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ReposinotuploadViewController.h"
#import "MyVideoCollectionViewCell.h"
#import "ShareWork+Morephotovideo.h"
#import "RecordModel.h"
#import "LargeViewController.h"

static NSString *kfooterIdentifier = @"footerIdentifier";
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kRecordheaderIdentifier = @"RecordHeaderIdentifier";

@interface ReposinotuploadViewController ()
{
    NSMutableArray * deleteOrUpdateArr;
    BOOL _isSelect;
    NSTimer * timer;
    UIButton * bigBtn;
    int timeee;
    NSUserDefaults *_standDefus;
    
}
@property (nonatomic,strong)UIButton * numBtn;
@property (nonatomic,strong)UIButton * rightBtn;
@property (nonatomic,strong)UIButton * deleteBtn;

@end

@implementation ReposinotuploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weishangchuan) name:@"weishangchuan" object:nil];
    //weishangchuanbianbian
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weishangchuanbianbian) name:@"weishangchuanbianbian" object:nil];
    
    
}
-(void)weishangchuanbianbian{
     [deleteOrUpdateArr removeAllObjects];
    _isSelect = NO;
    [self.collectionView reloadData];
    _deleteBtn.hidden = YES;

}


-(void)weishangchuan{
    //_isSelect = !_isSelect;
    if (_isSelect == YES) {
        _isSelect = NO;
    }else{
        _isSelect = YES;
    }
    [deleteOrUpdateArr removeAllObjects];
    _deleteBtn.hidden = YES;
    [self.collectionView reloadData];

}


-(void)setupData{
    [super setupData];
    deleteOrUpdateArr =[[NSMutableArray alloc]init];
    [self.dataSource addObject:[[RecordModel alloc] init]];
    
}
-(void)setupView{
    [super setupView];
    
    _deleteBtn = [[UIButton alloc]init];
    _deleteBtn.backgroundColor = YELLOW_COLOR;
    [_deleteBtn setTitle:@"Upload" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deleteBtn.superview);
        make.right.equalTo(_deleteBtn.superview);
        make.bottom.equalTo(_deleteBtn.superview);
        make.height.mas_equalTo(50);
    }];
    
    _deleteBtn.hidden = YES;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionView.superview);
        make.right.equalTo(self.collectionView.superview);
        make.top.equalTo(self.collectionView.superview.mas_top);
        make.bottom.equalTo(self.collectionView.superview.mas_bottom).offset(-60);
        
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    
    [self.collectionView registerClass:[MyVideoCollectionViewCell class] forCellWithReuseIdentifier:@"imageId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecordHeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecordheaderIdentifier];
    
    self.collectionView.backgroundColor =[UIColor whiteColor];
    
    [self initRefreshView];
    
}
-(void)loadDataSourceWithPage:(int)page{
    [deleteOrUpdateArr removeAllObjects];
       bigBtn.hidden = YES;
    [[ShareWork sharedManager]getVideoWithMid:Mid_S status:@"0" page:page complete:^(BaseModel *model) {
        if (model) {
            if (page == START_PAGE_INDEX) {
                [self.dataSource removeAllObjects];
                [self.dataSource addObject:[[RecordModel alloc] init]];
            }
            
            for (RecordModel * photoModel in model.list) {
                photoModel.networkaddressArray = [photoModel.networkaddress componentsSeparatedByString:@","];
                photoModel.thumbailsArray = [photoModel.thumbnails componentsSeparatedByString:@","];
                //   recordModel.typeArray = [recordModel.type componentsSeparatedByString:@","];
                photoModel.filenameArray = [photoModel.filename componentsSeparatedByString:@"," ];
            }
            
            if (model.list.count == 0) {
                self.collectionView.mj_footer.hidden = YES;
            }else{
                if (model.list.count<7) {
                    self.collectionView.mj_footer.hidden = YES;
                }else{
                    self.collectionView.mj_footer.hidden = NO;
                }
                
            }
            
            [self.dataSource addObjectsFromArray:model.list];
            
        }
        
        [self handleEndRefresh];
        [self.collectionView reloadData];
        
        
        
        
    }];
    
    
    
}

#pragma Mark  --- collectionDelegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    
    RecordModel *model = self.dataSource[section];
    
    return model.thumbailsArray.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.width - 4 * 10 ) / 4 , (collectionView.width - 4 * 10 ) / 4);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5,5);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return nil;
    }
    
    RecordModel *model = self.dataSource[indexPath.section];
    
    MyVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.thumbailsArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    
    cell.imageV.backgroundColor = [UIColor blackColor];
    cell.imageV.tag = 1000*(indexPath.section+1) +indexPath.row;
    cell.imageV.userInteractionEnabled = YES;
    
    //    if ([model.typeArray[indexPath.row] isEqualToString:@"video"]) {
    //  cell.startImageV.hidden = NO;
    //    }else{
    //        cell.startImageV.hidden = YES;
    //    }
    UITapGestureRecognizer *tapMYP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onVideo:)];
    [cell.imageV addGestureRecognizer:tapMYP];
    
    if (_isSelect == NO) {
        cell.rightBtn.hidden = YES;
    }else{
        cell.rightBtn.hidden = NO;
    }
    //    if (_isSelect == nil) {
    //        cell.rightBtn.hidden = NO;
    //    }
    
    cell.rightBtn.selected = NO;
    
    
    
    return cell;
}


//头部
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size;
    
    if (section == 0) {
        size = CGSizeMake(self.collectionView.width, 0 * W_Hight_Zoom);
    }else {
        size = CGSizeMake(self.collectionView.width, 20);
    }
    
    return size;
}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size ;
    
    if (section == 0) {
        size = CGSizeZero;
    }else{
        size = CGSizeMake(self.collectionView.width, 0);
    }
    
    return size;
}

// heder和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    UICollectionReusableView *view;
    
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
        view = [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        //        UILabel *label = (UILabel *)[view viewWithTag:1111];
        view.backgroundColor =[UIColor whiteColor];
        //  label.backgroundColor =[UIColor redColor];
    }else{
        reuseIdentifier = kheaderIdentifier;
        view = [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        UILabel *label = (UILabel *)[view viewWithTag:2222];
        
        view.backgroundColor =[UIColor whiteColor];
        
        RecordModel *model = self.dataSource[indexPath.section];
        
        label.text = model.opttime;
    }
    
    return view;
}


- (void)onVideo:(UITapGestureRecognizer *)imageSender
{
    //    NSUserDefaults * userdefautls = [NSUserDefaults standardUserDefaults];
    //    NSMutableArray * videoArrray = [userdefautls objectForKey:@"respositVideo"];
    //    if (videoArrray.count >0) {
    //        [[AppUtil appTopViewController] showHint:NSLocalizedString(@"resourece_war", nil)];
    //        return;
    //    }
    //
    NSInteger i = imageSender.view.tag/1000;//分区
    int j = imageSender.view.tag%1000;//每个分区的分组
    
    RecordModel *model = self.dataSource[i - 1];
    NSArray *imageA  = model.filenameArray;
    MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i-1]];
    if (_isSelect == NO) {
//        NSLog(@"dada");
//        LargeViewController * largVc =[[LargeViewController alloc]init];
//        largVc.dataArray = model.networkaddressArray;
//        [self.navigationController pushViewController:largVc animated:NO];
//        _deleteBtn.hidden = YES;
        
    }else{
        //
        //    if (deleteOrUpdateArr.count>=4) {
        //        if (cell.rightBtn.selected == YES) {
        //       //     cell.rightBtn.hidden = YES;
        //            cell.rightBtn.selected = NO;
        //            [deleteOrUpdateArr removeObject:imageA[j]];//把要删除的图片从删除数组中删除
        //        }else{
        //            [[AppUtil appTopViewController] showHint:NSLocalizedString(@"resourece_pic", nil)];
        //            return;
        //        }
        //    }else{
        
        if (deleteOrUpdateArr.count>=1) {
//            [[AppUtil appTopViewController] showHint:@"Only select a video"];
//            return;
        if (cell.rightBtn.selected == YES) {
       //     cell.rightBtn.hidden = YES;
            cell.rightBtn.selected = NO;
            [deleteOrUpdateArr removeObject:imageA[j]];//把要删除的图片从删除数组中删除
        }else{
            [[AppUtil appTopViewController] showHint:@"Only select a video"];
            return;
        }
            
        }else{
        
        
        
        if (cell.rightBtn.selected == NO) {
            //cell.rightBtn.hidden = NO;
            cell.rightBtn.selected = YES;
            [deleteOrUpdateArr addObject:imageA[j]];//把要删除的图片加入删除数组
            
        }else{
            //   cell.rightBtn.hidden = YES;
            cell.rightBtn.selected = NO;
            [deleteOrUpdateArr removeObject:imageA[j]];//把要删除的图片从删除数组中删除
        }
        //  }
        //
        //    if (deleteOrUpdateArr.count>0) {
        //        _numBtn.hidden = NO;
        //        [_numBtn setTitle:[NSString stringWithFormat:@"%ld",deleteOrUpdateArr.count] forState:UIControlStateNormal];
        //        [_rightBtn setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
        //        _rightBtn.selected = NO;
        //    }else{
        //        _numBtn.hidden = YES;
        //        // _numBtn.backgroundColor = [UIColor redColor];
        //        [_rightBtn setTitleColor:RGB(220, 220, 220) forState:UIControlStateNormal];
        //        //_rightBtn.selected = YES;
        //    }
        //
        //    NSUserDefaults * userdefautls2 = [NSUserDefaults standardUserDefaults];
        //    [userdefautls2 setObject:deleteOrUpdateArr forKey:@"repositImage"];
        // [userdefautls2 synchronize];
        
       
        }
    }
    if (deleteOrUpdateArr.count<1) {
        _deleteBtn.hidden = YES;
    }else{
        _deleteBtn.hidden = NO;
        
    }
    
    
}

-(void)deleteButtonTouch{
//    NSString *date = [AppUtil getNowTime];
//    NSUserDefaults *standDefus = [NSUserDefaults standardUserDefaults];
//    [standDefus setObject:date forKey:@"dateTimeee"];
//    [standDefus synchronize];
    
    
//    NSString *date = [AppUtil getNowTime];
//    int dateOver = [self spare:date];
    
    NSString * devinoce = [Defaluts objectForKey:@"deviceNumber"];
    if ([AppUtil isBlankString:devinoce]&&[AppUtil isBlankString:Mid_D]) {
        [[AppUtil appTopViewController]showHint:@"You have not bound a petcamera"];
        return;
    }
    
    NSString * filenameString = [deleteOrUpdateArr componentsJoinedByString:@","];
    [[ShareWork sharedManager]uploadVideoWithMid:Mid_S deviceno:Mid_D termid:Mid_T filename:filenameString complete:^(BaseModel *model) {
        if ([model.retCode isEqualToString:@"0000"]) {
            NSString *date = [AppUtil getNowTime];
            //存起来的数据，用作下一次进来的时候查询
             _standDefus = [NSUserDefaults standardUserDefaults];
            [_standDefus setObject:date forKey:@"dateTimeee"];
            [_standDefus setObject:model.content forKey:@"videocontent"];
            [_standDefus synchronize];
            //请求次数，12次，5秒一次
            timeee = 12;
            timer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(checkVideoStats:) userInfo:model.content repeats:YES];
            [timer setFireDate:[NSDate distantPast]];
            bigBtn = [[UIButton alloc]init];
            bigBtn.backgroundColor = [UIColor blackColor];
            bigBtn.alpha = 0.4;
            [[UIApplication sharedApplication].keyWindow addSubview:bigBtn];
            [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bigBtn.superview);
                make.bottom.equalTo(bigBtn.superview);
                make.left.equalTo(bigBtn.superview);
                make.right.equalTo(bigBtn.superview);
            }];
            
        }else{
            [[AppUtil appTopViewController]showHint:model.retDesc];

        }

    }];
    
}

- (void)checkVideoStats:(NSTimer *)tid
{
    
     timeee--;
     [self showHudInView:self.view hint:@"Uploading..."];
     [[ShareWork sharedManager]queryTaskWithTid:tid.userInfo complete:^(BaseModel *model) {
         if ([model.retCode isEqualToString:@"0000"]) {
             if ([model.content isEqualToString:@"0"]) {
                 if (timeee == 0) {
                      [[AppUtil appTopViewController]showHint:@"Overtime"];
                     [self hideHud];
                     bigBtn.hidden = YES;
                        [timer setFireDate:[NSDate distantFuture]];
                     _isSelect = NO;
                     [self initRefreshView];
                     [_standDefus removeObjectForKey:@"dateTimeee"];
                     [_standDefus removeObjectForKey:@"videocontent"];
                     
                 }else{
                     return ;
                 }
             }else if ([model.content isEqualToString:@"1"]){
                   [[AppUtil appTopViewController]showHint:@"Success"];
                 [self hideHud];
                  bigBtn.hidden = YES;
                 
                 [timer setFireDate:[NSDate distantFuture]];
                 _isSelect = NO;
                 [self initRefreshView];
                 [_standDefus removeObjectForKey:@"dateTimeee"];
                  [_standDefus removeObjectForKey:@"videocontent"];
             }else if ([model.content isEqualToString:@"2"]){
                 [[AppUtil appTopViewController]showHint:@"Failed"];
                  [self hideHud];
                   bigBtn.hidden = YES;
                    [timer setFireDate:[NSDate distantFuture]];
                 _isSelect = NO;
                 [self initRefreshView];
                 [_standDefus removeObjectForKey:@"dateTimeee"];
                  [_standDefus removeObjectForKey:@"videocontent"];
             }
         }else{
        
          [[AppUtil appTopViewController]showHint:@"Failed"];
              [self hideHud];
               bigBtn.hidden = YES;
                [timer setFireDate:[NSDate distantFuture]];
             _isSelect = NO;
             [self initRefreshView];
             [_standDefus removeObjectForKey:@"dateTimeee"];
              [_standDefus removeObjectForKey:@"videocontent"];
         }
         
         
         //  bigBtn.hidden = YES;
     }];


}


- (int )spare:(NSString *)str
{
    int a =[[str substringWithRange:NSMakeRange(0, 2)] intValue];
    int b =[[str substringWithRange:NSMakeRange(3, 2)] intValue];
    int c=[[str substringWithRange:NSMakeRange(6, 2)] intValue];
    
    a= (a*3600)+(b*60)+c;
    return a;
    
}



@end
