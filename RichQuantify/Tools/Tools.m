//
//  Tools.m
//  LeftSlide
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 zws. All rights reserved.
//

#import "Tools.h"
#import <objc/runtime.h>
@implementation Tools
{
    NSString *ivarOne;
    NSString *ivarTwo;
    NSString *ivarThree;
    NSString *ivarFour;
    NSString *ivarFive;
    unsigned int count;
}

#pragma mark --- 判断手机号格式是否正确
/**
 *  判断手机号格式是否正确
 *
 *  @param mobileNum 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,177
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark --- 验证电子邮箱
/**
 *  电子邮件
 *
 *  @param email 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark --- 验证qq号
/**
 *  qq
 *
 *  @param qqNum 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isQqNumber:(NSString *)qqNum
{
    NSString *qqstr = @"[1-9][0-9]{4,}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqstr];
    return [qqTest evaluateWithObject:qqNum];
}

#pragma mark ---- 过滤特殊字符 ，字母_.-@开头6到32位
/**
 字母_.-@开头6到32位
 */
+(BOOL)isIncludeSpecialCharact: (NSString *)str
{
    //^[a-zA-Z][a-zA-Z0-9_]*$
    NSString *phoneRegex = @"^[a-zA-Z][a-zA-Z0-9_.@-]{5,31}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}

#pragma mark 正则表达式／判断第一个是否以字母开头的方法
+(BOOL)matchFisrtChart:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    if ([regextestA evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark --- 判空提示
/**
 *  对输入的字符串进行是否为空验证
 *
 *  @param str         需要进行验证的字符串
 *  @param warningText 警告文本，如果为空，则显示
 *
 *  @return 字符串不为空，则返回YES，否则返回NO
 *
 *  @since 1.0
 */
+ (BOOL)isStringIsNull:(NSString *)str WarningText:(NSString *)warningText
{
    if ([str isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:warningText delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}

#pragma mark --- 用正则表达式对输入的字符串进行合法检测
/**
 *  用正则表达式对输入的字符串进行合法检测
 *
 *  @param trimmedString 需要检测的字符串
 *  @param regex         进行匹配的正则表达式
 *
 *  @return 如果合法，返回YES,否则返回NO
 *
 *  @since 1.0
 */
+ (BOOL)isStringIsRight:(NSString *)trimmedString andRegexString:(NSString *)regex
{
    NSPredicate *predicateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if([predicateTest evaluateWithObject:trimmedString])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark --- 判断文件夹是否存在
/**
 *  判断文件夹是否存在，
 *
 *  @param path       传入文件夹名称
 *
 *  @return bool 返回文件夹是否存在
 */
+ (BOOL)isExistFile:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        return false;
    }
    return true;
}

#pragma mark --- 判断是否为字典类型
/**
 *  检查对象是否是一个字典
 *
 *  @param mDictionary 需要检查的对象
 *
 *  @return 是否是一个字典
 *
 *  @since 1.0
 */
+ (BOOL)isNSDictionary:(id)mDictionary
{
    if (mDictionary && [mDictionary isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    return NO;
}

#pragma mark --- 判断是否为数组
/**
 *  检查对象是否是一个数组
 *
 *  @param mArray 需要检查的对象
 *
 *  @return 是否是一个数组
 *
 *  @since 1.0
 */
+ (BOOL)isNSArray:(id)mArray
{
    if (mArray && [mArray isKindOfClass:[NSArray class]])
    {
        return YES;
    }
    return NO;
}

#pragma mark --- 绘制view的边框
/**
 *  绘制view的边界
 *
 *  @since 1.0
 */
+ (void)viewBoderOfTest:(UIView *)view
{
    {
        view.layer.borderColor = [UIColor redColor].CGColor;
        view.layer.borderWidth = 1;
    }
}

#pragma mark --- 通用的警告框提示
/**
 *  通用的警告框提示
 *
 *  @param title       警告框的Title
 *  @param message     警告框的内容
 *  @param cancelTitle 取消按钮的名字
 *
 *  @since 1.0
 */
+ (void)alertFormatofTitle:(NSString *)title withMessage:(NSString *)message withCancelBtnTitle:(NSString *)cancelTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alert show];
}

#pragma mark --- 生成一个随机颜色
/**
 *  返回随机颜色
 *
 *  @return UIColor
 *
 *  @since 1.0
 */
+ (UIColor *)colorLightRandom
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 );  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark --- 根据RGB返回UIColor
/**
 *  根据RGB返回UIColor。
 *  return  UIColor
 *
 *  @since 1.0
 */
+ (UIColor *)colorRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    UIColor *color = [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
    return color;
}

#pragma mark --- 根据十六进制颜色值返回UIColor
/**
 *  根据十六进制颜色值返回UIColor。
 *
 *
 *  return  UIColor。
 *
 *  @since 1.0
 */
+ (UIColor *)colorFromHex:(NSInteger)hexColor
{
    return [UIColor colorWithRed:((float) ((hexColor & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((hexColor & 0xFF00)   >> 8))  / 0xFF
                            blue:((float)  (hexColor & 0xFF))            / 0xFF
                           alpha:1.0];
}

#pragma mark --- 根据十六进制颜色值返回UIColor
/**
 *	@brief	根据十六进制颜色值返回UIColor。
 *
 *	@return	UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


#pragma mark --- 图片压缩
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f)
    {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes)
        {
            break;
        }
        else
        {
            lastData = dataKBytes;
        }
    }
    return data;
}

#pragma mark --- 将图片转化成jpg格式
+ (void)compressMethod2OriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size completion:(void(^)(BOOL isJPEG, NSData *data))completion
{
    
    BOOL isJPEG = NO;
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    if (data)
    {
        isJPEG = YES;
        while (data.length > size*1024)
        {
            CGFloat scale = (size*1024.0f)/data.length;
            data = UIImageJPEGRepresentation(image, scale+0.01f);
        }
    }
    else
    {
        NSLog(@"不能转JPEG");
        data = UIImagePNGRepresentation(image);
        isJPEG = NO;
    }
    if (completion)
    {
        completion(isJPEG, data);
    }
}

#pragma mark --- 将UIColor变换为UIImage
/**
 * 将UIColor变换为UIImage
 *
 *  @param  color    颜色对象
 *
 *  return  theImage 图片对象
 *
 *  @since 1.0
 */
+ (UIImage *)imageCreateWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark --- 将image压缩为指定宽高的大小
/**
 *  将image压缩为指定宽高的大小
 *
 *  @param image         传入uiimage
 *  @param width         传入图片需要压缩的宽度
 *  @param height        传入图片需要压缩的高度
 *
 *  @return 返回已经转好的uiimage
 */
+ (UIImage *)imageScale:(UIImage *)image withWidth:(CGFloat) width andHeight:(CGFloat) height
{
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark --- 保持原来的长宽比，生成一个缩略图
/**
 *  保持原来的长宽比，生成一个缩略图
 *
 *  @param image  原始图片
 *  @param asize 要压缩到的尺寸
 *
 *  @return 压缩好的图片
 *
 *  @since 1.0
 */
+ (UIImage *)imageThumbnail:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image)
    {
        newimage = nil;
    }
    else
    {
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height)
        {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else
        {
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

#pragma mark --- 裁剪图片
/**
 *  剪切图片
 *
 *  @param image      原始图片
 *  @param mCGRect    需要的尺寸
 *  @param centerBool 是否居中剪切
 *
 *  @return 剪切后图片
 *
 *  @since 1.0
 */
+ (UIImage*)imageThumbnail:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool
{
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
    {
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    }
    else
    {
        if (viewheight < viewwidth)
        {
            if (imgwidth <= imgheight)
            {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }
            else
            {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0)
                {
                    rect = CGRectMake(x, 0, width, imgheight);
                }
                else
                {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }
        else
        {
            if (imgwidth <= imgheight)
            {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight)
                {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }
                else
                {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }
            else
            {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth)
                {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }
                else
                {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

#pragma mark --- 将image转任意角度
/**
 *  将image转任意角度的方法
 *
 *  @param image        传入uiimage
 *  @param orientation  image的旋转方向
 *  @pram  rotate       角度
 *
 *  @return 返回已经转好的uiimage
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation andRotate:(float)rotate
{
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    switch (orientation)
    {
        case UIImageOrientationLeft:
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}

#pragma mark --- 添加图片缩略参数
//添加图片缩略参数
+ (NSURL *)makeAppendScaleParagramWithImageAddress:(NSString *)str
{
    NSString *strPath = [NSString stringWithFormat:@"%@?imageMogr2/thumbnail/240x240!",str];
    NSURL *url = [NSURL URLWithString:strPath];
    return url;
}

//添加图片缩略参数
+ (NSString *)appendScaleParagramWithImageAddress:(NSString *)str
{
    NSString *strPath = [NSString stringWithFormat:@"%@?imageMogr2/thumbnail/240x240!",str];
    return strPath;
}

#pragma mark ---  获取指定宽度width,字体大小fontSize,字符串的高度
/**
 * 获取指定宽度width,字体大小fontSize,字符串value的高度
 *
 * @param value     待计算的字符串
 * @param width     限制字符串显示区域的宽度
 *
 * @result float    返回的高度
 *
 *  @since 1.0
 */
+ (CGFloat)heightForString:(NSString *)value andWidth:(float)width
{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc]
                                   initWithString:value
                                   attributes:@{
                                                NSFontAttributeName : [UIFont fontWithName:@"ZhaimiMedium-" size:15],
                                                NSForegroundColorAttributeName : [UIColor colorWithRed:86.0/255.0 green:90.0/255.0 blue:92.0/255.0 alpha:1.0]
                                                }];
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height;
}

#pragma mark --- 根据字体大小决定size的大小
/**
 *  根据字体大小决定size的大小
 *
 *  @since 1.0
 */
+ (CGSize)boundingRectWithSize:(CGSize)size withText:(NSString *)text withfont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}

#pragma mark ---  获取字符串的size
/**
 *  获取字符串的size
 *
 *  @param aString 原始字符串
 *
 *  @return 字符串的size
 *
 *  @since 1.0
 */
+ (CGSize)getStringRect:(NSString*)aString
{
    CGSize size;
    if (!aString)
    {
        return CGSizeMake(0, 0);
    }
    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
    NSRange range = NSMakeRange(0, atrString.length);
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    if ([([[UIDevice currentDevice] systemVersion]) floatValue] >= 7.0)
    {
        CGSize mSize =  CGSizeMake(150, 200);
        size = [aString boundingRectWithSize:mSize  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }
    else
    {
        size = [atrString size];
    }
    return  size;
}

+ (CGSize)getStringRect:(NSString*)aString withSize:(CGSize)mSize
{
    CGSize size;
    if (!aString)
    {
        return CGSizeMake(0, 0);
    }
    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
    NSRange range = NSMakeRange(0, atrString.length);
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    if ([([[UIDevice currentDevice] systemVersion]) floatValue] >= 7.0)
    {
        //CGSize mSize =  CGSizeMake(200, 200);
        size = [aString boundingRectWithSize:mSize  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }
    else
    {
        size = [atrString size];
    }
    return  size;
}

#pragma mark --- 时间戳转换标准时间
/**
 *  时间戳转换标准时间
 *
 *  @since 1.0
 */
+ (NSString *)timeStandard:(NSString *)timeStamp
{
    double lastactivityInterval = [timeStamp doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

#pragma mark --- 标准时间转换时间戳
/**
 *  标准时间转换时间戳
 *
 *  @since 1.0
 */
+ (NSString *)timeStamp:(NSString *)timeStandard
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:timeStandard];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

#pragma mark --- 格式化时间
/**
 *  格式化时间
 *
 *  @since 1.0
 */
+ (NSString *)timeDate:(NSString *)aString
{
    if ([aString isEqualToString:@""])
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@ %@",[aString substringWithRange:NSMakeRange(0, 10)],[aString substringWithRange:NSMakeRange(11, 5)]];
}

#pragma mark --- 格式化时间字符串
/**
 *  格式化时间字符串
 *
 *  @return 时间字符串
 *
 *  @since 1.0
 */
+ (NSString *)timeString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma mark --- 判断视频播出时间跟现在时间的差值
/**判断视频播出时间跟现在时间的差值 */
+ (NSString *)spaceTimeWithNowTimeWithTimeStr:(NSString *)timeStr
{
    NSTimeInterval timeNow = [[NSDate date] timeIntervalSince1970];
    long long int datelInt = (long long int)timeNow+8*60*60;
    long long int timeInt = [timeStr longLongValue];
    long long int spaceInt = datelInt - timeInt;
    if (spaceInt >=10*24*60*60)
    {
        return @"10天前";
    }
    else if (spaceInt >= 5*24*60*60)
    {
        return @"5天前";
    }
    else if (spaceInt >= 4*24*60*60)
    {
        return @"4天前";
    }
    else if (spaceInt >= 3*24*60*60)
    {
        return @"3天前";
    }
    else if (spaceInt >= 2*24*60*60)
    {
        return @"2天前";
    }
    else if (spaceInt >=24*60*60)
    {
        return @"1天前";
    }
    else if (spaceInt >=60*60)
    {
        return [NSString stringWithFormat:@"%lld小时前",spaceInt/60/60];
    }
    else if (spaceInt >=60)
    {
        return [NSString stringWithFormat:@"%lld分钟前",spaceInt/60];
    }
    else
    {
        return @"1分钟前";
    }
}

#pragma mark --- 计算指定时间与当前的时间差
/**
 * 计算指定时间与当前的时间差
 *
 * @param compareDate   某一指定时间
 *
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 *
 *  @since 1.0
 */
+ (NSString *)timeCompareCurrent:(NSDate *)compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval =  [[NSDate date] timeIntervalSinceNow] - timeInterval;
    int temp = 0;
    NSString *result;
    if (timeInterval < 60)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60)
    {
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    else if((temp = temp/60) <24)
    {
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    else if((temp = temp/24) <30)
    {
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    else if((temp = temp/30) <12)
    {
        result = [NSString stringWithFormat:@"%d个月前",temp];
    }
    else
    {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    return  result;
}

#pragma mark --- 时间差，友好时间
/**
 *  友好时间
 *
 *  @param dataTime 时间
 *
 *  @return 友好时间
 *
 *  @since 1.0
 */
+ (NSString *)timeFindendliy:(NSString *)dataTime
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式 年yyyy 月 MM 日dd 小时hh(HH) 分钟 mm 秒 ss MMM单月 eee周几 eeee星期几 a上午下午
    //与字符串保持一致
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //现在的时间转换成字符串
    NSDate * nowDate = [NSDate date];
    NSString * noewTime = [formatter stringFromDate:nowDate];
    //参数字符串转化成时间格式
    NSDate * date = [formatter dateFromString:dataTime];
    //参数时间距现在的时间差
    NSTimeInterval time = -[date timeIntervalSinceNow];
    NSLog(@"%f",time);
    //上述时间差输出不同信息
    if (time < 60)
    {
        return @"刚刚";
    }
    else if (time <3600)
    {
        int minute = time/60;
        NSString * minuteStr = [NSString stringWithFormat:@"%d分钟前",minute];
        return  minuteStr;
    }
    else
    {
        //如果年不同输出某年某月某日
        if ([[dataTime substringToIndex:4] isEqualToString:[noewTime substringToIndex:4]])
        {
            //截取字符串从下标为5开始 2个
            NSRange rangeM = NSMakeRange(5, 2);
            //如果月份不同输出某月某日某时
            if ([[dataTime substringWithRange:rangeM]isEqualToString:[noewTime substringWithRange:rangeM]])
            {
                NSRange rangD = NSMakeRange(8, 2);
                //如果日期不同输出某日某时
                if ([[dataTime substringWithRange:rangD]isEqualToString:[noewTime substringWithRange:rangD]])
                {
                    NSRange rangeSSD = NSMakeRange(11, 5);
                    NSString * Rstr = [NSString stringWithFormat:@"今日%@",[dataTime substringWithRange:rangeSSD]];
                    return  Rstr;
                }
                else
                {
                    NSRange rangSD = NSMakeRange(5, 5);
                    return [dataTime substringWithRange:rangSD];
                }
            }
            else
            {
                NSRange rangeSM = NSMakeRange(5,5);
                return [dataTime substringWithRange:rangeSM];
            }
        }
        else
        {
            return [dataTime substringToIndex:10];
        }
    }
}

#pragma mark --- 判空，检查字符串Object 是否为空，如果为<null>等，则统一为@""
/**
 *  检查字符串Object 是否为空，如果为<null>等，则统一为@""
 *
 *  @param object 需要检查的字符串
 *
 *  @return 返回修改好的字符串
 *
 *  @since 1.0
 */
+(NSString *)strCheckPostObject:(id)object
{
    if ([object isEqual:[NSNull class]])
    {
        return [NSString stringWithFormat:@""];
    }
    else if([object isKindOfClass:[NSNull class]])
    {
        return [NSString stringWithFormat:@""];
    }
    else
    {
        if (object == nil || [object isEqualToString:@"<null>"] || [object isEqualToString:@"(null)"])
        {
            return [NSString stringWithFormat:@""];
        }
        return object;
    }
    return [NSString stringWithFormat:@""];
}

#pragma mark --- 截取字符串
/**
 *  截取字符串
 *
 *  @param str 传入str
 *
 *  @return 返回str
 *
 *  @since 1.0
 */
+ (NSString *)strFromStr:(NSString *)str withIndex:(NSInteger )index
{
    NSString *strBack;
    if (str.length > index)
    {
        strBack = [NSString stringWithFormat:@"%@...",[str substringToIndex:index]];
    }
    else
    {
        strBack = str;
    }
    return strBack;
}

#pragma mark ---  返回字段payMethod英文转中文
/**
 *  返回字段payMethod英文转中文
 *
 *  @param pyStr 剪切图的URL
 *
 *  @return 原始图的URL
 *
 *  @since 1.0
 */
+ (NSString *)strBackPayMethodInChinese:(NSString *)pyStr
{
    if ([pyStr isEqualToString:@"cash"])
    {
        return @"货到付款";
    }
    else if ([pyStr isEqualToString:@"alipay"])
    {
        return @"支付宝";
    }
    else if ([pyStr isEqualToString:@"balance"])
    {
        return @"余额支付";
    }
    else if ([pyStr isEqualToString:@"wechar"])
    {
        return @"微信支付";
    }
    return pyStr;
}

#pragma mark --- 获取共享文件夹的路径
/**
 *  获取共享文件夹的路径
 *
 *  @param filePath 文件名称
 *
 *  @return 带共享文件夹的文件路径
 *
 *  @since 1.0
 */
+ (NSString*)shareFilePath:(NSString*)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent: filePath];
}

#pragma mark --- 获取原始图的URL
/**
 *  获取原始图的URL
 *
 *  @param url 剪切图的URL
 *
 *  @return 原始图的URL
 *
 *  @since 1.0
 */
+ (NSString*)sortImageUrl:(NSString*)url
{
    NSArray* items = [url componentsSeparatedByString:@".JPG"];
    if (items.count < 2)
    {
        items = [url componentsSeparatedByString:@".jpg"];
    }
    if (items.count < 2)
    {
        return url;
    }
    NSString* result = items[items.count- 2];
    result =  [result substringToIndex:[result length]-2];
    result = [result stringByAppendingString:@".jpg"];
    return result;
}

#pragma mark --- 返回Array所描述的字符串
/**
 *  返回Array所描述的字符串
 字典格式如下：
 @[@{@"string":@"单价",@"isMainColor":@NO},
 @{@"string":strPrice,@"isMainColor":@YES},
 @{@"string":totalPrice,@"isMainColor":@NO}]
 *
 *  @param strArray 字符串Array
 *
 *  @return NSAttributedString
 *
 *  @since 1.0
 */
+ (NSAttributedString *)getAttributedStringWithArray:(NSArray *)strArray withFont:(UIFont *)font
{
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    for (NSDictionary *item in strArray)
    {
        UIColor *color = [item[@"isMainColor"] boolValue] ? [UIColor colorWithRed:50.0/255.0 green:162.0/255.0 blue:248.0/255.0 alpha:1.0] : [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
        NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                         initWithString:item[@"string"]
                                         attributes:@{
                                                      NSFontAttributeName : font,
                                                      NSForegroundColorAttributeName :color
                                                      }];
        [str appendAttributedString:p1];
    }
    return str;
}

#pragma mark --- 返回数组中描述的NSAttributedString
/**
 *  返回icofont NSAttributedString
 *
 *  @param strArray 描述数组
 *
 *  @return NSAttributedString
 *
 *  @since 1.0
 */
+(NSAttributedString *)getIcoFontWithArray:(NSArray *)strArray
{
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    for (NSDictionary *item in strArray)
    {
        CGFloat fontSize = [item[@"fontSize"] floatValue];
        UIColor *color = [item[@"isMainColor"] boolValue] ? [UIColor colorWithRed:50.0/255.0 green:162.0/255.0 blue:248.0/255.0 alpha:1.0] : [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
        UIFont *font = [item[@"isIcoFont"] boolValue] ? [UIFont fontWithName:@"iconfont" size:fontSize] : [UIFont fontWithName:@"ZhaimiMedium-" size:fontSize];
        NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                         initWithString:item[@"string"]
                                         attributes:@{
                                                      NSFontAttributeName : font,
                                                      NSForegroundColorAttributeName :color
                                                      }];
        [str appendAttributedString:p1];
    }
    return str;
}

#pragma mark --- 返回NSAttributedString，左侧String为灰色，右侧为kMainColor
/**
 *  返回NSAttributedString，左侧String为灰色，右侧为kMainColor
 *
 *  @param firstStr 左侧String
 *  @param lastStr  右侧String
 *  @param fontSize 字体大小
 *
 *  @return 返回NSAttributedString
 *
 *  @since 1.0
 */
+(NSAttributedString *)getAttributedStringWithFirstString:(NSString *)firstStr
                                               firstColor:(UIColor *)firstColor
                                            andLastString:(NSString *)lastStr
                                                lastColor:(UIColor *)lastColor
                                             withFontSize:(CGFloat )fontSize
{
    UIFont *font = [UIFont fontWithName:@"ZhaimiMedium-" size:fontSize];
    NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                     initWithString:firstStr
                                     attributes:@{
                                                  NSFontAttributeName : font,
                                                  NSForegroundColorAttributeName :firstColor
                                                  }];
    NSMutableAttributedString *p2 = [[NSMutableAttributedString alloc]
                                     initWithString:lastStr
                                     attributes:@{
                                                  NSFontAttributeName : font,
                                                  NSForegroundColorAttributeName :lastColor
                                                  }];
    [p1 appendAttributedString:p2];
    return p1;
}

#pragma mark --- 返回IcoFont NSAttributedString，左侧String为灰色，右侧为kMainColor
/**
 *  返回IcoFont NSAttributedString，左侧String为灰色，右侧为kMainColor
 *
 *  @param firstStr 左侧String
 *  @param lastStr  右侧String
 *
 *  @return 返回NSAttributedString
 *
 *  @since 1.0
 */
+(NSAttributedString *)getIcoFontAttributedStringWithFirstString:(NSString *)firstStr
                                                      firstColor:(UIColor *)firstColor
                                                       firstFont:(UIFont *)firstFont
                                                   andLastString:(NSString *)lastStr
                                                       lastColor:(UIColor *)lastColor
                                                        lastFont:(UIFont *)lastFont
{
    NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                     initWithString:firstStr
                                     attributes:@{
                                                  NSFontAttributeName : firstFont,
                                                  NSForegroundColorAttributeName :firstColor
                                                  }];
    NSMutableAttributedString *p2 = [[NSMutableAttributedString alloc]
                                     initWithString:lastStr
                                     attributes:@{
                                                  NSFontAttributeName : lastFont,
                                                  NSForegroundColorAttributeName :lastColor
                                                  }];
    [p1 appendAttributedString:p2];
    return p1;
}

#pragma mark --- 2个地理坐标距离
/*
 2个坐标距离
 常用到如image1.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(335));
 CGAffineTransformMakeRotation中要填的是弧度，所以要转换一下。
 下面是两个宏，来实现互转
 1。弧度转角度
 #define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
 NSLog(@”Output radians as degrees: %f”, RADIANS_TO_DEGREES(0.785398));
 2。角度转弧度
 // Degrees to radians
 #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
 NSLog(@”Output degrees as radians: %f”, DEGREES_TO_RADIANS(45));
 M_PI 定义在Math.h内，其值为3.14159265358979323846264338327950288
 */
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
+ (NSString *)locationWithLatitude:(NSString *)firstLatitude withLongitude:(NSString *)firstLongitude WithLatitude:(NSString *)secondLatitude withLongitude:(NSString *)secondLongitude
{
    double firLat = [firstLatitude doubleValue];
    double secLat = [secondLatitude doubleValue];
    double firLng = [firstLongitude doubleValue];
    double secLng = [secondLongitude doubleValue];
    double theta = firLng - secLng;
    double miles = (sin(DEGREES_TO_RADIANS(firLat)) * sin(DEGREES_TO_RADIANS(secLat))) + (cos(DEGREES_TO_RADIANS(firLat)) * cos(DEGREES_TO_RADIANS(secLat)) * cos(DEGREES_TO_RADIANS(theta)));
    miles = acos(miles);
    miles = RADIANS_TO_DEGREES(miles);
    miles = miles * 60 * 1.1515;// 英里
    //double feet = miles * 5280; //英尺
    double kilometers = miles * 1.609344; //千米
    kilometers = kilometers * 1000;
    kilometers = round(kilometers);
    NSString *milsStr = [NSString stringWithFormat:@"%0.f", kilometers];
    return milsStr;
}

#pragma mark --- 有效数字字符串
/** 有效数字字符串 */
+ (NSString *)significantFigureStringWithString:(NSString *)string
{
    int count = [string intValue];
    if (count>10000)
    {
        return [NSString stringWithFormat:@"%.2lf万",count/10000.0];
    }
    else if(count > 100000000)
    {
       return [NSString stringWithFormat:@"%.2lf亿",count/100000000.0];
    }
    else
    {
        return string;
    }
}

#pragma mark - json字符串转字典
/** json字符串转字典 */
+ (NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dictionary;
}

#pragma mark --- 字典转json字符串
/** 字典转json字符串 */
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark --- 16进制的字符串转data
/** 16进制的字符串 转data*/
+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0)
    {
        return nil;
    }
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0)
    {
        range = NSMakeRange(0, 2);
    }
    else
    {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2)
    {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

#pragma mark --- 将data转换成16进制的字符串
/**将data 转换成16进制的字符串 */
+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0)
    {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop)
    {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++)
        {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2)
            {
                [string appendString:hexStr];
            }
            else
            {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

#pragma mark --- 内存大小
/**统计系统内存大小*/
+ (CGFloat)systemSize
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fattributes = [fm attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    //NSLog(@"容量%lldG",[[fattributes objectForKey:NSFileSystemSize] longLongValue]/1000000000);
    //NSLog(@"可用%lldG",[[fattributes objectForKey:NSFileSystemFreeSize] longLongValue]/1000000000);
    return ([[fattributes objectForKey:NSFileSystemFreeSize] doubleValue]/(1024.0*1024.0));
}


#pragma mark --- runtime方法
#pragma mark --- 获取属性列表
- (void)getPropertyList
{
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for(unsigned int i = 0;i<count;i++)
    {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property----->%@",[NSString stringWithUTF8String:propertyName]);
    }
}

#pragma mark ---获取方法列表
- (void)getMethList
{
    Method *methodList = class_copyMethodList([self class], &count);
    for(unsigned int i = 0 ; i<count;i++)
    {
        Method method = methodList[i];
        NSLog(@"method----->%@",NSStringFromSelector(method_getName(method)));
    }
}

#pragma mark --- 获取成员变量列表
- (void)getIvarList
{
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for(unsigned int i = 0; i<count;i++)
    {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar--->%@",[NSString stringWithUTF8String:ivarName]);
    }
}

#pragma mark --- 获取协议列表
- (void)getProtocolList
{
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for(unsigned int i = 0;i<count;i++)
    {
        Protocol *myProtocol = protocolList[i];
        const char *protocolName = protocol_getName(myProtocol);
        NSLog(@"protocol--->%@",[NSString stringWithUTF8String:protocolName]);
    }
}


@end
