//
//  BJQRCodeHeader.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//

#ifndef BJQRCodeHeader_h
#define BJQRCodeHeader_h
#import "UIView+Frame.h"
#import "BJCheckSystemRight.h"
//宏定义
//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//屏幕
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceSize   [[UIScreen mainScreen] bounds].size

#endif /* BJQRCodeHeader_h */
