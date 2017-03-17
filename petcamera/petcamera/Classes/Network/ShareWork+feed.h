//
//  ShareWork+feed.h
//  petcamera
//
//  Created by yulei on 17/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork.h"

@interface ShareWork (feed)


//查询喂食设置
-(void)queryFeedingtimeWithMid:(NSString *)mid
                        status:(NSString *)status
                      complete:(void(^)(BaseModel *model))completeBlock;

//添加喂食
-(void)addFeedingtimeWithMid:(NSString *)mid
                        type:(NSString *)type
                       times:(NSString *)times
                    deviceno:(NSString *)deviceno
                      termid:(NSString *)termid
                    complete:(void(^)(BaseModel *model))completeBlock;

//删除喂食
-(void)cancelFeedingtimeWithbrid:(NSString *)brid
                        deviceno:(NSString *)deviceno
                          termid:(NSString *)termid
                        complete:(void(^)(BaseModel *model))completeBlock;

@end
