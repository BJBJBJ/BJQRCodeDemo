//
//  BJQRCodeDevice.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/18.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BJQRCodeDevice : NSObject

+(instancetype)qrCodeDevice;
/**
 *  配置参数
 */
-(void)configurationpreviewLayer:(void(^)(CGRect*frame,CALayer**preViewLayer))
                      configurationpreviewLayerBlock;
/**
 *  开始扫描
 */
-(void)startScan;
/**
 *  结束扫描
 */
-(void)stopScan;
/**
 *  扫描完成回调
 */
-(void)scanResultCallBack:(void(^)(NSString*resultCode,NSString*errorStr))scanResultBlock;
@end
