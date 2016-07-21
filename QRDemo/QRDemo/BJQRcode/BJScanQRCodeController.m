//
//  BJScanQRCodeController.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/18.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "BJScanQRCodeController.h"
#import "BJQRCodeViewfinder.h"
#import "BJQRCodeDevice.h"

@interface BJScanQRCodeController()
@property(nonatomic,strong)BJQRCodeViewfinder*qrCodeViewfinder;
@property(nonatomic,strong)BJQRCodeDevice*qrCodeDevice;
@end

@implementation BJScanQRCodeController
-(BJQRCodeViewfinder *)qrCodeViewfinder{
    if (!_qrCodeViewfinder) {
        _qrCodeViewfinder=[BJQRCodeViewfinder qrCodeViewfinder];
        _qrCodeViewfinder.frame=CGRectMake(0, 0,kDeviceWidth-100 , kDeviceWidth-80);
    }
    return _qrCodeViewfinder;
}
-(BJQRCodeDevice *)qrDevice{
    if (!_qrCodeDevice) {
        _qrCodeDevice=[BJQRCodeDevice qrCodeDevice];
    }
    return _qrCodeDevice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkright];
    [self scanQRCodeCallBack];
    
}
/** 检查权限*/
-(void)checkright{
    WS(ws)
    [BJCheckSystemRight checkCameraRightCallBack:^(NSError *error) {
        if (!error) {
            [ws startScan];
        }else{
            UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:error.domain delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [altert show];
        }
    }];
}
/** 开启扫描*/
-(void)startScan{
    self.qrCodeViewfinder.center=self.view.center;
    [self.view addSubview:self.qrCodeViewfinder];
   
    [self.qrDevice configurationpreviewLayer:^(CGRect *frame, CALayer *__autoreleasing *preViewLayer) {
        CGRect  rect=CGRectMake(self.qrCodeViewfinder.x, self.qrCodeViewfinder.y, self
                                .qrCodeViewfinder.width, self.qrCodeViewfinder.height-20);
        *frame=rect;
        *preViewLayer=self.view.layer;
    }];

    [self.qrDevice startScan];
    [self.qrCodeViewfinder scanLineStartRoll];

}
/** 停止扫描*/
-(void)stopScan{
    [self.qrCodeDevice stopScan];
    [self.qrCodeViewfinder scanLineStopRoll];
}
/** 扫描回调*/
-(void)scanQRCodeCallBack{
    
    WS(ws)
    [self.qrCodeDevice scanResultCallBack:^(NSString *resultCode, NSString *errorStr) {
        [ws stopScan];
        if (!errorStr) {
            UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"扫描结果" message:resultCode delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [altert show];
        
        }else{
    
            UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [altert show];
            
        }
    }];
    
 
}
@end
