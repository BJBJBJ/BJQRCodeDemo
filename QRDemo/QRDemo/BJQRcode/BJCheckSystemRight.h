//
//  BJCheckSystemRight.h
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//

//检测权限
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BJCheckSystemRight : NSObject

/**
 * @"设备不支持"      code:-10000
 * @"用户授权失败"     code:-10001
 * @"访问受限"        code:-10002
 * @"用户已拒绝授权"   code:-10003
 */

/**
 *  检测相机权限
*/
+(void)checkCameraRightCallBack:(void(^)(NSError*error))checkBlock;
/**
 *  检测相册权限
 */
+(void)checkPhotosRightCallBack:(void(^)(NSError*error))checkBlock;



@end












