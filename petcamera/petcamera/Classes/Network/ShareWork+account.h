//
//  ShareWork+account.h
//  petcamera
//
//  Created by yulei on 17/2/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork.h"
#import "BaseModel.h"

@interface ShareWork (account)
- (void)loginWithUserName:(NSString*)userName password:(NSString*)password  complete:(void(^)(BaseModel *model))completeBlock;

@end
