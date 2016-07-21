//
//  BJCheckSystemRight.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "BJCheckSystemRight.h"
#import <objc/runtime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
@implementation BJCheckSystemRight

+(void)checkCameraRightCallBack:(void(^)(NSError*error))checkBlock{
         __block   NSError*error=nil;
            //判断设备是否支持相机
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            error=[NSError errorWithDomain:@"设备不支持" code:-10000 userInfo:nil];
            !checkBlock?:checkBlock(error);
                return;
        }
      switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]){
                 //已授权
            case  AVAuthorizationStatusAuthorized:
                !checkBlock?:checkBlock(error);
                break;
                //未进行授权选择
            case AVAuthorizationStatusNotDetermined:{
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted){//用户授权成功
                        !checkBlock?:checkBlock(error);
                    }else{
                        error=[NSError errorWithDomain:@"用户授权失败" code:-10001 userInfo:nil];
                        !checkBlock?:checkBlock(error);
                    }
                }];
              }
                break;
                //未授权，且用户无法更新，如家长控制情况下
            case  AVAuthorizationStatusRestricted:
                error=[NSError errorWithDomain:@"访问受限" code:-10002 userInfo:nil];
                !checkBlock?:checkBlock(error);
                break;
                //用户拒绝授权
            case AVAuthorizationStatusDenied:
                error=[NSError errorWithDomain:@"用户已拒绝授权" code:-10003 userInfo:nil];
                !checkBlock?:checkBlock(error);
                break;
     }
    

}
+(void)checkPhotosRightCallBack:(void(^)(NSError*error))checkBlock{
         __block   NSError*error=nil;
    
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            error=[NSError errorWithDomain:@"设备不支持" code:-10000 userInfo:nil];
            !checkBlock?:checkBlock(error);
            return;
        }
      switch ([ALAssetsLibrary authorizationStatus]) {
            case ALAuthorizationStatusAuthorized:
                  !checkBlock?:checkBlock(error);
                break;
              //未进行授权操作
            case ALAuthorizationStatusNotDetermined:
                  !checkBlock?:checkBlock(error);
                break;
            case ALAuthorizationStatusRestricted:
                error=[NSError errorWithDomain:@"访问受限" code:-10002 userInfo:nil];
                !checkBlock?:checkBlock(error);
                break;
            case ALAuthorizationStatusDenied:
                error=[NSError errorWithDomain:@"用户已拒绝授权" code:-10003 userInfo:nil];
                !checkBlock?:checkBlock(error);
                break;
      }
}
@end
