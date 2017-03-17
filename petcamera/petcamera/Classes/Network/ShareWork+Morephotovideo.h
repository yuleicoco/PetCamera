//
//  ShareWork+Morephotovideo.h
//  petcamera
//
//  Created by czx on 2017/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork.h"

@interface ShareWork (Morephotovideo)
//抓拍
-(void)getPhotoGraphWithMid:(NSString *)mid page:(int)page complete:(void (^)(BaseModel * model))completeBlock;

//删除抓拍
-(void)delPhotoGraphWith:(NSString *)mid filename:(NSString *)filename complete:(void (^)(BaseModel * model))completeBlock;

//录像
-(void)getVideoWithMid:(NSString *)mid status:(NSString *)status page:(int)page complete:(void (^)(BaseModel * model))completeBlock;

//删除录像
-(void)delVideoWithMid:(NSString *)mid filename:(NSString *)filename complete:(void (^)(BaseModel * model))completeBlock;

//上传录像
-(void)uploadVideoWithMid:(NSString *)mid deviceno:(NSString *)deviceno termid:(NSString *)termid filename:(NSString *)filename complete:(void (^)(BaseModel * model))completeBlock;

//查询录像上传进度
-(void)queryTaskWithTid:(NSString *)tid complete:(void (^)(BaseModel * model))completeBlock;





@end

