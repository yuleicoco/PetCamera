//
//  ShareWork+Incall.h
//  petcamera
//
//  Created by yulei on 17/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork.h"

@interface ShareWork (Incall)

//喂食
-(void)feed:(NSString *)dev
                        ter:(NSString *)ter
                      complete:(void(^)(BaseModel *model))completeBlock;

//开灯
-(void)light:(NSString *)dev
        ter:(NSString *)ter
      action:(NSString *)act
   complete:(void(^)(BaseModel *model))completeBlock;

//零食
-(void)roll:(NSString *)dev
         ter:(NSString *)ter
        num:(NSString *)num
    complete:(void(^)(BaseModel *model))completeBlock;

//抓拍
-(void)photo:(NSString *)dev
        ter:(NSString *)ter
   complete:(void(^)(BaseModel *model))completeBlock;


// 声音


// 结束设备使用记录

-(void)DeviceUse:(NSString *)num
    complete:(void(^)(BaseModel *model))completeBlock;

//开始设备记录
-(void)DeviceUseMember:(NSString *)mid object :(NSString *)object deviceno:(NSString *)deviceno belong:(NSString *)belong starttime:(NSString *)starttime    complete:(void (^)(BaseModel *))completeBlock;


@end
