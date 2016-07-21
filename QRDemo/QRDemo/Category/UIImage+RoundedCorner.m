//
//  UIImage+RoundedCorner.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/20.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "UIImage+RoundedCorner.h"

@implementation UIImage(RoundedCorner)
#pragma mark---------Private---------
/** 给上下文添加圆角*/
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image){
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width=CGRectGetWidth(rect);
    height=CGRectGetHeight(rect);
    
    //裁剪路径 画弧
    CGContextMoveToPoint(context, width, height*0.5);
    CGContextAddArcToPoint(context, width, height, width*0.5, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height*0.5, radius);
    CGContextAddArcToPoint(context, 0, 0, width*0.5, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height*0.5, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}
-(UIImage *)setRoundedCornerWith:(CGFloat)radius{
    if (!self) { return nil; }
    
    const CGFloat width=self.size.width;
    const CGFloat height=self.size.height;
    //radius 5~10
    radius=MAX(5.f, radius);
    radius=MIN(10.f, radius);
    
    UIImage * img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //绘制圆角
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage: imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    return img;
}
@end
