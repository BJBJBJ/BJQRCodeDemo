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
-(BJQRCodeDevice *)qrCodeDevice{
    if (!_qrCodeDevice) {
        _qrCodeDevice=[BJQRCodeDevice qrCodeDevice];
    }
    return _qrCodeDevice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkright];
  
    
}

/** 检查权限*/
-(void)checkright{
    WS(ws)
    [BJCheckSystemRight checkCameraRightCallBack:^(NSError *error) {
        if (!error) {
            
            
            if([NSThread isMainThread]){
                
                   [ws startScan];
            }
            else{
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                       [ws startScan];
                }];
                
            }

            
         
        }else{
            
            if([NSThread isMainThread]){
                
                UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:error.domain delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [altert show];

            }
            else{
            
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:error.domain delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [altert show];
                    
                }];
            
            }
        }
    }];
}
/** 开启扫描*/
-(void)startScan{
    self.qrCodeViewfinder.center=self.view.center;
    [self.view addSubview:self.qrCodeViewfinder];
   
    [self.qrCodeDevice configurationpreviewLayer:^(CGRect *frame, CALayer *__autoreleasing *preViewLayer) {
        CGRect  rect=CGRectMake(self.qrCodeViewfinder.x, self.qrCodeViewfinder.y, self
                                .qrCodeViewfinder.width, self.qrCodeViewfinder.height-20);
        *frame=rect;
        *preViewLayer=self.view.layer;
    }];

    
    if (_qrCodeDevice) {
        [_qrCodeDevice startScan];
        [_qrCodeViewfinder scanLineStartRoll];
    }
    
    
    if (_qrCodeDevice) {
         [self scanQRCodeCallBack];
    }
    
}
/** 停止扫描*/
-(void)stopScan{
    if (_qrCodeDevice) {
        [_qrCodeDevice stopScan];
        [_qrCodeViewfinder scanLineStopRoll];
    }
   
}
/** 扫描回调*/
-(void)scanQRCodeCallBack{
    
    WS(ws)
    [_qrCodeDevice scanResultCallBack:^(NSString *resultCode, NSString *errorStr) {
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
