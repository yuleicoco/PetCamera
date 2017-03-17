//
//  ShareWork+device.m
//  petcamera
//
//  Created by yulei on 17/2/8.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork+device.h"

@implementation ShareWork (device)

-(void)DeviceStats:(NSString *)mid   complete:(void (^)(BaseModel *))completeBlock
{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"mid"] = mid;
   
    [self requestWithMethod:POST WithPath:@"common=queryMyDevice" WithParams:parms WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
           // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

   
}

-(void)AddDeviceStats:(NSString *)mid deviceno:(NSString *)deviceno   complete:(void (^)(BaseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"mid"] = mid;
    parms[@"deviceno"]= deviceno;
    
    [self requestWithMethod:POST WithPath:@"common=addDevice" WithParams:parms WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            // NSLog(@"哈哈");
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
}

-(void)RemoveDevice:(NSString *)mid   complete:(void (^)(BaseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"mid"] = mid;
    
    [self requestWithMethod:POST WithPath:@"common=delDevice" WithParams:parms WithSuccessBlock:^(BaseModel *model) {
        
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
