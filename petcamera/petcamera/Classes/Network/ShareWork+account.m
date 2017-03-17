//
//  ShareWork+account.m
//  petcamera
//
//  Created by yulei on 17/2/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork+account.h"

@implementation ShareWork (account)

- (void)loginWithUserName:(NSString*)userName password:(NSString*)password  complete:(void(^)(BaseModel *model))completeBlock
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"accountnumber"] = userName;
    params[@"password"] = password;
    
     
    
    [self requestWithMethod:POST WithPath:@"common=memberLogin" WithParams:params WithSuccessBlock:^(BaseModel *model) {
        
        if (model) {
            NSLog(@"哈哈");
        }
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
    
}

@end
