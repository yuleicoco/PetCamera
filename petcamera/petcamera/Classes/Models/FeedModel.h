//
//  FeedModel.h
//  petcamera
//
//  Created by yulei on 17/2/10.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import <MojoDatabase/MojoDatabase.h>

@interface FeedModel : JSONModel

@property (nonatomic,copy)NSString <Optional> * opttime;
@property (nonatomic,copy)NSString <Optional> * mid;
@property (nonatomic,copy)NSString <Optional> * times;
@property (nonatomic,copy)NSString <Optional> * type;
@property (nonatomic,copy)NSString <Optional> * brid;

@end
