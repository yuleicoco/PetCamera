//
//  ShareWork.m
//  petcamera
//
//  Created by yulei on 17/2/6.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import "ShareWork.h"

@implementation ShareWork

// 创建类方法
+ (instancetype)sharedManager
{
    static ShareWork * manager =nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://180.97.80.227:15102/"]];
    });
    return manager;
    
  
    
    
}

// 重写父类方法
-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
         self.securityPolicy.allowInvalidCertificates = YES;
        
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    
                    break;
                default:
                    break;
            }

        }];
        [self.reachabilityManager startMonitoring];
       
    }
    return self;
}


// 方法封装
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(id)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    switch (method) {
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                BaseModel * model =[[BaseModel  alloc]initWithDictionary:responseObject error:nil];
                success(model);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        case POST:{
     
            //http://app.smartsuoo.com:15102/ web服务器域名和端口
            // app=sip sip服务器的地址
            
            
            
            path =[NSString  stringWithFormat:@"http://app.smartsuoo.com:15102/clientAction.do?method=json&classes=appinterface&%@",path];
        
            
           // path =@"http://180.97.80.227:15102/clientAction.do?method=json&classes=appinterface&common=memberLogin";
            

        
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                 NSError* error = nil;
                
                BaseModel * model =[[BaseModel  alloc]initWithDictionary:responseObject[@"jsondata"] error:&error];
                
                success(model);
                
                
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}
            

// 销毁 [self.operationQueue cancelAllOperations];

@end
