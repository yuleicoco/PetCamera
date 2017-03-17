//
//  BaseModel.h
//  petcamera
//
//  Created by yulei on 17/2/7.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel

@property (nonatomic, copy) NSDictionary<Optional> *retVal;

@property (nonatomic, copy) NSString<Optional> *content;

@property (nonatomic, copy) NSString<Optional> *retDesc;

@property (nonatomic, copy) NSString<Optional> *retCode;

@property (nonatomic, copy) NSString<Optional> *totalrecords;

@property (nonatomic, strong) NSArray<Optional> *list;

@end
