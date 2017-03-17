//
//  PhotoViewController.m
//  petcamera
//
//  Created by czx on 2017/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "PhotoViewController.h"
#import "MyVideoCollectionViewCell.h"
#import "ShareWork+Morephotovideo.h"
#import "PhotoGrapgModel.h"
#import "LargeViewController.h"

static NSString *kfooterIdentifier = @"footerIdentifier";
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kRecordheaderIdentifier = @"RecordHeaderIdentifier";
@interface PhotoViewController ()
{
    NSMutableArray * deleteOrUpdateArr;
    BOOL _isSelect;
}
@property (nonatomic,strong)UIButton * numBtn;
@property (nonatomic,strong)UIButton * rightBtn;
@property (nonatomic,strong)UIButton * deleteBtn;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    _isSelect = NO;
    [self setNavTitle:@"Photo"];
    [self showBarButton:NAV_RIGHT title:@"Select" fontColor:[UIColor whiteColor] hide:NO];
    
}
-(void)setupData{
    [super setupData];
        deleteOrUpdateArr =[[NSMutableArray alloc]init];
    [self.dataSource addObject:[[PhotoGrapgModel alloc] init]];

}
-(void)doRightButtonTouch{
    [deleteOrUpdateArr removeAllObjects];
    _isSelect = !_isSelect;
    if (_isSelect == YES) {
        [self showBarButton:NAV_RIGHT title:@"Cancel" fontColor:[UIColor whiteColor] hide:NO];
       // _deleteBtn.hidden = NO;
    }else{
        [self showBarButton:NAV_RIGHT title:@"select" fontColor:[UIColor whiteColor] hide:NO];
        _deleteBtn.hidden = YES;
    }
    [self.collectionView reloadData];
}






-(void)setupView{
    [super setupView];
    
    _deleteBtn = [[UIButton alloc]init];
    _deleteBtn.backgroundColor = YELLOW_COLOR;
    [_deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
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
    [[ShareWork sharedManager]getPhotoGraphWithMid:[AccountManager sharedAccountManager].loginModel.mid page:page complete:^(BaseModel *model) {
        if (model) {
            if (page == START_PAGE_INDEX) {
                [self.dataSource removeAllObjects];
                [self.dataSource addObject:[[PhotoGrapgModel alloc] init]];
            }
            
            for (PhotoGrapgModel * photoModel in model.list) {
                photoModel.networkaddressArray = [photoModel.networkaddress componentsSeparatedByString:@","];
                photoModel.imagenameArray = [photoModel.imagename componentsSeparatedByString:@","];
                //   recordModel.typeArray = [recordModel.type componentsSeparatedByString:@","];
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
    
    PhotoGrapgModel *model = self.dataSource[section];
    
    return model.imagenameArray.count;
    
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
    
    PhotoGrapgModel *model = self.dataSource[indexPath.section];
    
    MyVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.networkaddressArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"sego1.png"]];
    
    cell.imageV.backgroundColor = [UIColor blackColor];
    cell.imageV.tag = 1000*(indexPath.section+1) +indexPath.row;
    cell.imageV.userInteractionEnabled = YES;
    
    cell.startImageV.hidden = YES;
    //    if ([model.typeArray[indexPath.row] isEqualToString:@"video"]) {
    //  cell.startImageV.hidden = NO;
    //    }else{
    //        cell.startImageV.hidden = YES;
    //    }
    UITapGestureRecognizer *tapMYP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onVideo:)];
    [cell.imageV addGestureRecognizer:tapMYP];

    if (_isSelect == YES) {
        cell.rightBtn.hidden = NO;
    }else{
        cell.rightBtn.hidden = YES;
    }
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
        
        PhotoGrapgModel *model = self.dataSource[indexPath.section];
        
        label.text = model.pgtime;
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
    
    PhotoGrapgModel *model = self.dataSource[i - 1];
    NSArray *imageA  = model.imagenameArray;
    MyVideoCollectionViewCell *cell = (MyVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i-1]];
    if (_isSelect == NO) {
        NSLog(@"dada");
        LargeViewController * largVc =[[LargeViewController alloc]init];
        largVc.dataArray = model.networkaddressArray;
        [self.navigationController pushViewController:largVc animated:NO];
        _deleteBtn.hidden = YES;
        
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
        
        if (deleteOrUpdateArr.count<1) {
            _deleteBtn.hidden = YES;
        }else{
            _deleteBtn.hidden = NO;
        
        }
    }
}

-(void)deleteButtonTouch{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Are you sure to delete?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableString * filenameStr = [[NSMutableString alloc]init];
        
        if (deleteOrUpdateArr.count == 1) {
            NSString * str = [NSString stringWithFormat:@"%@",deleteOrUpdateArr[0]];
            [filenameStr appendFormat:@"'%@'",str];
            
            
        }else{
            for (int i = 0; i < deleteOrUpdateArr.count; i++) {
                NSString * strrr = [NSString stringWithFormat:@"%@",deleteOrUpdateArr[i]];
                if (i == deleteOrUpdateArr.count - 1) {
                    [filenameStr appendFormat:@"'%@'",strrr];
                }else{
                    [filenameStr appendFormat:@"'%@',",strrr];
                }
                
            }
            
        }
        
        [[ShareWork sharedManager]delPhotoGraphWith:Mid_S filename:filenameStr complete:^(BaseModel *model) {
            if (model) {
                //[self initRefreshView];
                _isSelect = NO;
                // [self loadDataSourceWithPage:0];
                [self initRefreshView];
                
            }
            
        }];
        
        

        
        
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
    
    
    


}







@end
