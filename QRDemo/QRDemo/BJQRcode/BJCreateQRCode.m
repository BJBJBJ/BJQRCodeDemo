//
//  BJCreateQRCode.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "BJCreateQRCode.h"
#import "UIImage+RoundedCorner.h"
@implementation BJCreateQRCode
BJCreateQRCode *instance=nil;
+(instancetype)share{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance=[[self alloc] init];
        });
    }
    return instance;
}

-(CIImage *)createQRCodeImageWith:(NSString *)qrCodeInfo{
    if (!qrCodeInfo || (NSNull *)qrCodeInfo==[NSNull null]) return nil;
        //1.创建滤镜
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
      //2.设置滤镜属性为默认值
    [qrFilter setDefaults];
    //3.设置需要生成二维码的数据到滤镜中
    NSData *data = [qrCodeInfo dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:data forKeyPath:@"InputMessage"];
    //二维码清晰度 清晰度越高容错率越高 H为30%
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    return [qrFilter outputImage];
}
-(UIImage*)convertHDQRCodeImageWith:(CIImage *)ciImage codeSize:(CGFloat)codeSize{
    
    if (!codeSize){codeSize=200.0;}
    //将CIImage转化为高清图片
    //绘制高清方法：CIImage->CGImageRef->UIImage 直接转换成UIImage，大小不好控制，图片模糊
    CGImageRef cgImage=[[CIContext contextWithOptions:nil] createCGImage:ciImage fromRect:ciImage.extent];
    UIGraphicsBeginImageContext(CGSizeMake(codeSize, codeSize));
    CGContextRef context=UIGraphicsGetCurrentContext();
    //在对二维码放大或缩小处理时,禁止插值
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);//翻转图片
    //将二维码绘制到图片上下文
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}

-(UIImage*)createHDQRCodeImageWith:(NSString *)qrCodeInfo onColor:(UIColor*)onColor offColor:(UIColor*)offColor codeSize:(CGFloat)codeSize{
    
    if (!onColor) {onColor=[UIColor blackColor];}
    if (!offColor) {offColor=[UIColor whiteColor];}
    
    CIImage *ciImage=[self createQRCodeImageWith:qrCodeInfo];
        //二维码的颜色上色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",ciImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    
    return [self convertHDQRCodeImageWith:[colorFilter outputImage] codeSize:codeSize];
}
-(UIImage*)createHDQRCodeImageWith:(NSString *)qrCodeInfo onColor:(UIColor *)onColor offColor:(UIColor *)offColor codeSize:(CGFloat)codeSize logo:(UIImage*)logoImage radius: (CGFloat)radius{
    
    UIImage *qrImage=[self createHDQRCodeImageWith:qrCodeInfo onColor:onColor offColor:offColor codeSize:codeSize];
    if (!logoImage) {
        NSLog(@"--%@-%@-logo为空",[self class],NSStringFromSelector(_cmd));
        return qrImage;
    }
    
    //添加圆角
    logoImage =[logoImage setRoundedCornerWith:radius];
    UIImage * whiteBG = [UIImage imageNamed: @"whiteBG"];
    whiteBG =[whiteBG setRoundedCornerWith:radius];
    
    //白色边缘宽度
    const CGFloat whiteSize = 5.f;
    //中间白框的size大小为二维码的0.25
    CGSize  brinkSize = CGSizeMake(qrImage.size.width*0.25, qrImage.size.height*0.25);
    CGFloat brinkX = (qrImage.size.width - brinkSize.width) * 0.5;
    CGFloat brinkY = (qrImage.size.height - brinkSize.height) * 0.5;
    //中间logo的size
    CGSize imageSize = CGSizeMake(brinkSize.width -2*whiteSize, brinkSize.height - 2 * whiteSize);
    CGFloat imageX = brinkX + whiteSize;
    CGFloat imageY = brinkY + whiteSize;
    
    //绘制图片
    UIGraphicsBeginImageContext(qrImage.size);
    [qrImage drawInRect: (CGRect){ 0, 0, (qrImage.size) }];
    [whiteBG drawInRect: (CGRect){ brinkX, brinkY, (brinkSize) }];
    [logoImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


@end
