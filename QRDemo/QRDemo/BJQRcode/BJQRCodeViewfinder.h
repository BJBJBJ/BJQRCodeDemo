//
//  BJQRCodeViewfinder.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/18.
//  Copyright © 2016年 zbj. All rights reserved.
//

//二维码取景框
#import <UIKit/UIKit.h>
#import "BJQRCodeHeader.h"
@interface BJQRCodeViewfinder : UIView

+(instancetype)qrCodeViewfinder;
/**
 *  开启扫描条滚动
 */
-(void)scanLineStartRoll;
/**
 *  扫描条停止滚动
 */
-(void)scanLineStopRoll;
@end
