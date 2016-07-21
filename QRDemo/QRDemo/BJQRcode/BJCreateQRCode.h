//
//  BJCreateQRCode.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//
//二维码生成
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BJCreateQRCode : NSObject

+(instancetype)share;
/**
 *  生成原始二维码
 *  @param qrCodeInfo 二维码信息
 *  @return           CIImage
 */
-(CIImage*)createQRCodeImageWith:(NSString*)qrCodeInfo;

/**
 *  原始二维码转换高清二维码
 *  @param ciImage    原始二维码
 *  @param codeSize   二维码宽高一致为矩形(默认200)
 *  @return           UIImage
 */
-(UIImage*)convertHDQRCodeImageWith:(CIImage *)ciImage codeSize:(CGFloat)codeSize;

/**
 *  生成高清二维码
 *  @param qrCodeInfo 二维码信息
 *  @param onColor    上色(默认为黑)
 *  @param offColor   间隙颜色(默认为白)
 *  @param codeSize   二维码宽高一致为矩形(默认200)
 *  @return UIImage
 */
-(UIImage*)createHDQRCodeImageWith:(NSString *)qrCodeInfo onColor:(UIColor*)onColor offColor:(UIColor*)offColor codeSize:(CGFloat)codeSize;

/**
 *  生成高清带有中间logo的二维码
 *
 *  @param qrCodeInfo 二维码信息
 *  @param onColor    上色(默认为黑)
 *  @param offColor   间隙颜色(默认为白)
 *  @param codeSize   二维码宽高一致为矩形(默认200)
 *  @param logoImage  logo(插入的logo的宽高默认最大为size的25%)
 *  @param radius     logo圆角弧度
 *  @return           UIImage
 */
-(UIImage*)createHDQRCodeImageWith:(NSString *)qrCodeInfo onColor:(UIColor *)onColor offColor:(UIColor *)offColor codeSize:(CGFloat)codeSize logo:(UIImage*)logoImage radius: (CGFloat)radius;

@end
