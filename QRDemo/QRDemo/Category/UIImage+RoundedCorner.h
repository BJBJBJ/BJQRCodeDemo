//
//  UIImage+RoundedCorner.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/20.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(RoundedCorner)
/**
 *  图片设置圆角
 *  @param radius 圆角弧度
 *  @return 返回圆角图片
 */
-(UIImage *)setRoundedCornerWith:(CGFloat)radius;
@end
