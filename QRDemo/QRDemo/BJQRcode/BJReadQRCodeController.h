//
//  BJReadQRCodeController.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJReadQRCodeController : UIViewController

/**
 *  读取二维码回调
 */
-(void)readQRCodeCallBack:(void(^)(NSString*resultCode,NSString*errorStr))readQRCodeBlock;

@end
