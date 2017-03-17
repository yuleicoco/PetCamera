//
//  AppUtil.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppUtil.h"


@implementation AppUtil


//方法

//硬件设备
static NSString* server = @"http://192.168.43.1:7766/rest/operate";

//赛果三期 外网服务器
//static NSString * getServer3 =@"http://180.97.80.227:15102/";
// 测试
//static NSString * getServer3 =@"http://180.97.81.213:15102/";
//static NSString * getServer3 =@"http://180.97.80.227:8080/";
static NSString * getServerTest = @"http://180.97.80.227:15102/";
//http://app.segoapp.xyz:15102
//英文版地址
static NSString * getServer3 =@"http://180.97.80.227:15102/";

static NSString * getServerTest1 = @"http://192.168.1.103:8080/sego_v3/";


+ (NSString *)getServerSego3
{
    return  getServer3;
}

+(NSString *)getServerTest{
    return getServer3;
}

+ (NSString*) getServer{
    return server;
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return true;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return true;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return true;
    }
    return false;
}

+ (CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha/255.0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref1 = CGColorCreate(colorSpace,(CGFloat[]){r, g,b, a });
    return colorref1;
}

+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1[34578]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (CGSize)lable:(UILabel *)sender scaleToSize:(CGSize)sizeL
{
    
    CGSize size = sizeL;
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[sender.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size;
    
}
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

+ (UIViewController *)appTopViewController{
    UIViewController *appRootVC = ApplicationDelegate.window.rootViewController;
    
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+(NSString *)getNowTime
{
    
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
    
    
    
}

+(NSString *)getCurrentTime{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
    
    
}

@end

