//
//  ShareWork+feed.m
//  petcamera
//
//  Created by yulei on 17/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork+feed.h"

@implementation ShareWork (feed)

-(void)queryFeedingtimeWithMid:(NSString *)mid status:(NSString *)status complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    
    [self requestWithMethod:POST WithPath:@"common=queryFeedingtime" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];


    
}


-(void)addFeedingtimeWithMid:(NSString *)mid type:(NSString *)type times:(NSString *)times deviceno:(NSString *)deviceno termid:(NSString *)termid complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"type"] = type;
    params[@"times"] = times;
    params[@"deviceno"] = deviceno;
    params[@"termid"] = termid;
    
    [self requestWithMethod:POST WithPath:@"common=setFeedingtime" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
}




-(void)cancelFeedingtimeWithbrid:(NSString *)brid deviceno:(NSString *)deviceno termid:(NSString *)termid complete:(void (^)(BaseModel *))  completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"brid"] = brid;
    params[@"deviceno"] = deviceno;
    params[@"termid"] = termid;
    [self requestWithMethod:POST WithPath:@"common=cancelFeedingtime" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
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
