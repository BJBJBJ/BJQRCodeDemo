//
//  BJQRCodeDevice.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/18.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "BJQRCodeDevice.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import "BJQRCodeHeader.h"

@interface BJQRCodeDevice()<AVCaptureMetadataOutputObjectsDelegate>
{
    //取景框的frame
    CGRect frame;
}
@property(nonatomic,strong)AVCaptureDeviceInput*inPut;
@property(nonatomic,strong)AVCaptureMetadataOutput *outPut;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;

@property(nonatomic,copy)void(^scanResultBlock)(NSString*resultCode,NSString*errorStr);
@end
@implementation BJQRCodeDevice

-(AVCaptureDeviceInput *)inPut{
    if (!_inPut) {
        NSError *error = nil;
       _inPut=[AVCaptureDeviceInput deviceInputWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:&error];
        if (error) {
            NSLog(@"没有摄像头%@", error.localizedDescription);
            return nil;
        }
    }
    return _inPut;
}
-(AVCaptureMetadataOutput *)outPut{
    if (!_outPut) {
       _outPut=[[AVCaptureMetadataOutput alloc] init];
         [_outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _outPut;
}
-(AVCaptureSession *)session{
    if (!_session) {
       _session=[[AVCaptureSession alloc]init];
            //清晰度
//       _session.sessionPreset=AVCaptureSessionPreset640x480;
        _session.sessionPreset=AVCaptureSessionPresetHigh;
        // 添加session的输入和输出
        if ([_session canAddInput:_inPut]) {[_session addInput:_inPut];}
        if ([_session canAddOutput:_outPut]) {[_session addOutput:_outPut];}
          // 需要解析的数据类型
       [_outPut setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }
    return _session;
}
-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer=[AVCaptureVideoPreviewLayer layerWithSession:_session];
        [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        _previewLayer.frame=CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    }
    return _previewLayer;
}
-(instancetype)init{
    if (self=[super init]) {
        [self inPut];
        [self outPut];
        [self session];
    }
    return self;
}
/**
 *  配置扫描范围
 */
-(void)configurationoutPutRectOfInterest{
    CGRect scanCrop=CGRectMake((kDeviceWidth-frame.size.width)*0.5,
               (kDeviceHeight - frame.size.height)*0.5,
               frame.size.width,
               frame.size.height);
    //设置扫描范围 0~1
    _outPut.rectOfInterest=CGRectMake(scanCrop.origin.y/kDeviceHeight,
               scanCrop.origin.x/kDeviceWidth,
               scanCrop.size.height/kDeviceHeight,
               scanCrop.size.width/kDeviceWidth
               );
}
+(instancetype)qrCodeDevice{
    return [[self alloc] init];
}
-(void)configurationpreviewLayer:(void(^)(CGRect*frame,CALayer**preViewLayer))configurationpreviewLayerBlock{
    if (!configurationpreviewLayerBlock) return;
    CALayer *layer;
    configurationpreviewLayerBlock(&frame,&layer);
    if (layer) {[layer insertSublayer:self.previewLayer atIndex:0];}
    [self configurationoutPutRectOfInterest];
}
-(void)startScan{
    [self.session startRunning];
}
-(void)stopScan{
    [self.session stopRunning];
}

-(void)scanResultCallBack:(void(^)(NSString*resultCode,NSString*errorStr))scanResultBlock;{
    self.scanResultBlock=scanResultBlock;
}
#pragma mark--------AVCaptureMetadataOutputObjectsDelegate------

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
      // 1.停止扫描
    [self.session stopRunning];
     // 2.取值
    if (metadataObjects!=nil && metadataObjects.count>0) {
        
        AVMetadataMachineReadableCodeObject *metadataObject =[metadataObjects firstObject];
        if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode]) {

            !self.scanResultBlock?: self.scanResultBlock(metadataObject.stringValue,nil);
        }else{
           !self.scanResultBlock?:self.scanResultBlock(nil,@"未识别的二维码");
        }
        
    }else{
         !self.scanResultBlock?:self.scanResultBlock(nil,@"未识别的二维码");
    }

    
}
@end
