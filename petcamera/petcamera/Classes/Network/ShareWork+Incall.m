//
//  ShareWork+Incall.m
//  petcamera
//
//  Created by yulei on 17/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork+Incall.h"

@implementation ShareWork (Incall)


//喂食
-(void)feed:(NSString *)dev
        ter:(NSString *)ter
   complete:(void(^)(BaseModel *model))completeBlock
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"deviceno"] = dev;
    params[@"termid"] = ter;
    
    [self requestWithMethod:POST WithPath:@"common=food" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

    
}

//开灯
-(void)light:(NSString *)dev
         ter:(NSString *)ter
      action:(NSString *)act
    complete:(void(^)(BaseModel *model))completeBlock
{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"deviceno"] = dev;
    params[@"termid"] = ter;
    params[@"action"] = act;
    [self requestWithMethod:POST WithPath:@"common=switchLight" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

    
}

//零食
-(void)roll:(NSString *)dev
        ter:(NSString *)ter
        num:(NSString *)num
   complete:(void(^)(BaseModel *model))completeBlock
{
    
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"deviceno"] = dev;
    params[@"termid"] = ter;
    params[@"id"] =num;
    [self requestWithMethod:POST WithPath:@"common=feeding" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

    
    
}

//抓拍
-(void)photo:(NSString *)dev
         ter:(NSString *)ter
    complete:(void(^)(BaseModel *model))completeBlock
{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"deviceno"] = dev;
    params[@"termid"] = ter;
    
    [self requestWithMethod:POST WithPath:@"common=photoGraph" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

    
}


// 声音


-(void)DeviceUse:(NSString *)num
        complete:(void(^)(BaseModel *model))completeBlock
{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
 
    params[@"id"] = num;
    
    [self requestWithMethod:POST WithPath:@"common=updateDeviceUseRecord" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

    
}

-(void)DeviceUseMember:(NSString *)mid object :(NSString *)object deviceno:(NSString *)deviceno belong:(NSString *)belong starttime:(NSString *)starttime    complete:(void (^)(BaseModel *))completeBlock
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"object"]= object;
    params[@"deviceno"] = deviceno;
    params[@"belong"]= belong;
    params[@"starttime"]= starttime;

    
    [self requestWithMethod:POST WithPath:@"common=addDeviceUseRecord" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
    
    
    
}

@end
