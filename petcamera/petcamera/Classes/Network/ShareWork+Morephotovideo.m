//
//  ShareWork+Morephotovideo.m
//  petcamera
//
//  Created by czx on 2017/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork+Morephotovideo.h"

@implementation ShareWork (Morephotovideo)
-(void)getPhotoGraphWithMid:(NSString *)mid page:(int)page complete:(void (^)(BaseModel *))completeBlock
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"page"] = @(page);

    [self requestWithMethod:POST WithPath:@"common=getPhotoGraph" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {

            model.list = [PhotoGrapgModel arrayOfModelsFromDictionaries:model.list];

        }
        
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
}

-(void)delPhotoGraphWith:(NSString *)mid filename:(NSString *)filename complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"filename"] = filename;
    
    [self requestWithMethod:POST WithPath:@"common=delPhotoGraph" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
        
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];

}

-(void)getVideoWithMid:(NSString *)mid status:(NSString *)status page:(int)page complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"status"] = status;
    params[@"page"] = @(page);
    [self requestWithMethod:POST WithPath:@"common=getVideo" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            
            model.list = [RecordModel arrayOfModelsFromDictionaries:model.list];
            
        }
        
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
    
    

}



-(void)delVideoWithMid:(NSString *)mid filename:(NSString *)filename complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"filename"] = filename;
    
    [self requestWithMethod:POST WithPath:@"common=delVideo" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];



}

-(void)uploadVideoWithMid:(NSString *)mid deviceno:(NSString *)deviceno termid:(NSString *)termid filename:(NSString *)filename complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"mid"] = mid;
    params[@"deviceno"] = deviceno;
    params[@"termid"] = termid;
    params[@"filename"] = filename;
    
    [self requestWithMethod:POST WithPath:@"common=uploadVideo" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];






}


-(void)queryTaskWithTid:(NSString *)tid complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"tid"] = tid;
    [self requestWithMethod:POST WithPath:@"common=queryTask" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];



}







@end
