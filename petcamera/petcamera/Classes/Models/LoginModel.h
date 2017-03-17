//
//  LoginModel.h
//  petegg
//
//  Created by czx on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <MojoDatabase/MojoDatabase.h>
#import "JSONModel.h"


@interface LoginModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *accountnumber;

@property (nonatomic, copy) NSString<Optional> *address;

@property (nonatomic, copy) NSString<Optional> *createtime;

@property (nonatomic, copy) NSString<Optional> *deviceno;

@property (nonatomic, copy) NSString<Optional> *dwid;

@property (nonatomic, copy) NSString<Optional> * email;

@property (nonatomic, copy) NSString<Optional> *headportrait;

@property (nonatomic, copy) NSString<Optional> *incode;

@property (nonatomic, copy) NSString<Optional> *mid;

@property (nonatomic, copy) NSString<Optional> *nickname;

@property (nonatomic, copy) NSString<Optional> *opttime;

@property (nonatomic, copy) NSString<Optional> *password;

@property (nonatomic, copy) NSString<Optional> *pet_age;

@property (nonatomic, copy) NSString<Optional> * pet_birthday;

@property (nonatomic, copy) NSString<Optional> * pet_createtime;

@property (nonatomic, copy) NSString<Optional> * pet_nickname;

@property (nonatomic, copy) NSString<Optional> * pet_opttime;

@property (nonatomic ,copy) NSString<Optional> * pid;

@property (nonatomic, copy) NSString<Optional> * pet_race;

@property (nonatomic, copy) NSString<Optional> * pet_sex;

@property (nonatomic, copy) NSString<Optional> * signature;

@property (nonatomic, copy) NSString<Optional> * sipno;

@property (nonatomic, copy) NSString<Optional> * sippw;

@property (nonatomic, copy) NSString<Optional> * state;

@property (nonatomic, copy) NSString<Optional> * termid;

@end
