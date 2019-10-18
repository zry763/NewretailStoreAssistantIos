//
//
//
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "BaseScanViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


@implementation LightBT

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // image center
    CGPoint center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    //text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end

@interface BaseScanViewController ()

@end

@implementation BaseScanViewController


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self stopScan];
    
#ifdef LBXScan_Define_UI
    [_qRScanView stopScanAnimation];
#endif
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startScan];

    
}

-(LBXScanViewStyle*)style{
    if (!_style) {
        _style=[[LBXScanViewStyle alloc]init];
        //扫码框周围4个角的类型设置为在框的上面,可自行修改查看效果
        _style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;

        _style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
        //扫码框周围4个角绘制线段宽度
        _style.photoframeLineW = 2;

        //扫码框周围4个角水平长度
        _style.photoframeAngleW = 16;

        //扫码框周围4个角垂直高度
        _style.photoframeAngleH = 16;

        //扫码框周围4个角的颜色
        _style.colorAngle = [TRCColor colorFromHexCode:@"#FE3125"];

        //是否显示扫码框
        _style.isNeedShowRetangle = YES;
        //扫码框颜色
        _style.colorRetangleLine = [TRCColor colorFromHexCode:@"#FE3125"];

        //非扫码框区域颜色(扫码框周围颜色，一般颜色略暗)
        //必须通过[UIColor colorWithRed: green: blue: alpha:]来创建，内部需要解析成RGBA
        _style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

    }
    return _style;
}


-(void)addSomeSubviews{

    
    [self.qRScanView addSubview:self.toastLable];
    
    [self.qRScanView addSubview:self.lapBt];
    
    int XRetangleLeft = self.style.xScanRetangleOffset;
    CGSize sizeRetangle = CGSizeMake(self.qRScanView.frame.size.width - XRetangleLeft*2, self.qRScanView.frame.size.width - XRetangleLeft*2);
    
    if (self.style.whRatio != 1)
    {
        CGFloat w = sizeRetangle.width;
        CGFloat h = w / self.style.whRatio;
        
        NSInteger hInt = (NSInteger)h;
        h  = hInt;
        
        sizeRetangle = CGSizeMake(w, h);
    }
    
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.qRScanView.frame.size.height / 2.0 - sizeRetangle.height/2.0 - self.style.centerUpOffset;
    //扫码区域坐标
    self.scanRect =  CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height);
    
    TRC_BLOCK_WEAK_SELF
    
    [self.toastLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.qRScanView);
        make.top.equalTo(weakSelf.qRScanView).with.offset(30+self.scanRect.origin.y+ sizeRetangle.height);
        
    }];
    
    [self.lapBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.qRScanView);
        make.top.equalTo(weakSelf.qRScanView).with.offset(-40+self.scanRect.origin.y+ sizeRetangle.height);
    }];
    
}
-(UILabel *)toastLable{
    if (!_toastLable) {
        _toastLable = [[UILabel alloc]init];
        [_toastLable setFont:[UIFont systemFontOfSize:16 ]];
        [_toastLable setTextColor:[TRCColor colorFromHexCode:@"#999999"]];
        _toastLable.text =@"请出示二维码";
        
    }
    return _toastLable;
    
}
-(LightBT *)lapBt{
    if (!_lapBt) {
        _lapBt = [LightBT buttonWithType:UIButtonTypeCustom];
        [_lapBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lapBt.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_lapBt setTitle:@"轻触点亮" forState: UIControlStateNormal];
        [_lapBt setTitle:@"轻触关闭" forState: UIControlStateSelected];

        [_lapBt addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
        [_lapBt setImage:[UIImage imageNamed:@"onLight"] forState:UIControlStateNormal];
        [_lapBt setImage:[UIImage imageNamed:@"onLight1"] forState:UIControlStateSelected];


    }
    return _lapBt;
}
- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor blackColor];

    self.hbd_barAlpha = 0.0;
    
    self.hbd_barStyle = UIBarStyleBlack;
    self.hbd_tintColor = UIColor.whiteColor;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {

        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
}
-(void)setupSubviews{
    [self drawScanView];
    [self requestCameraPemissionWithResult:^(BOOL granted) {
        
        if (granted) {
            
            //不延时，可能会导致界面黑屏并卡住一会
            [self performSelector:@selector(startScan) withObject:nil afterDelay:0];
            
        }else{
            
#ifdef LBXScan_Define_UI
            [_qRScanView stopDeviceReadying];
            
#endif
            
        }
    }];
    
    
}


//绘制扫描区域
- (void)drawScanView
{
#ifdef LBXScan_Define_UI
    
    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:self.style];
        
        [self.view addSubview:_qRScanView];
    }
    
    if (!_cameraInvokeMsg) {
        
        //        _cameraInvokeMsg = NSLocalizedString(@"wating...", nil);
    }
    
//    [_qRScanView startDeviceReadyingWithText:_cameraInvokeMsg];
#endif
}

- (void)reStartDevice
{
    switch (_libraryType) {
        case SLT_Native:
        {
#ifdef LBXScan_Define_Native
            [_scanObj startScan];
#endif
        }
            break;
        case SLT_ZXing:
        {
#ifdef LBXScan_Define_ZXing
            [_zxingObj start];
#endif
        }
            break;
        case SLT_ZBar:
        {
#ifdef LBXScan_Define_ZBar
            [_zbarObj start];
#endif
        }
            break;
        default:
            break;
    }
    
}

//启动设备
- (void)startScan
{
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    videoView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:videoView atIndex:0];
    __weak __typeof(self) weakSelf = self;
    
    switch (_libraryType) {
        case SLT_Native:
        {
            
            
#ifdef LBXScan_Define_Native
            
            if (!_scanObj )
            {
                 CGRect cropRect = CGRectZero;
                
                if (_isOpenInterestRect) {
                    
                    //设置只识别框内区域
                    cropRect = [LBXScanView getScanRectWithPreView:self.view style:self.style];
                }
                
                NSString *strCode = AVMetadataObjectTypeQRCode;
                if (_scanCodeType != SCT_BarCodeITF ) {
                    
                    strCode = [self nativeCodeWithType:_scanCodeType];
                }
                
                //AVMetadataObjectTypeITF14Code 扫码效果不行,另外只能输入一个码制，虽然接口是可以输入多个码制
                self.scanObj = [[LBXScanNative alloc]initWithPreView:videoView ObjectType:@[strCode] cropRect:cropRect success:^(NSArray<LBXScanResult *> *array) {
                    
                    [weakSelf scanResultWithArray:array];
                }];
                [_scanObj setNeedCaptureImage:_isNeedScanImage];
            }
            [_scanObj startScan];
#endif
            
        }
            break;
        case SLT_ZXing:
        {
            
#ifdef LBXScan_Define_ZXing
            if (!_zxingObj) {
                
                __weak __typeof(self) weakSelf = self;
                self.zxingObj = [[ZXingWrapper alloc]initWithPreView:videoView block:^(ZXBarcodeFormat barcodeFormat, NSString *str, UIImage *scanImg) {
                    
                    LBXScanResult *result = [[LBXScanResult alloc]init];
                    result.strScanned = str;
                    result.imgScanned = scanImg;
                    result.strBarCodeType = [weakSelf convertZXBarcodeFormat:barcodeFormat];
                    
                    [weakSelf scanResultWithArray:@[result]];
                    
                }];
                
                if (_isOpenInterestRect) {
                    
                    //设置只识别框内区域
                    CGRect cropRect = [LBXScanView getZXingScanRectWithPreView:videoView style:self.style];
                    
                    [_zxingObj setScanRect:cropRect];
                }
            }
            [_zxingObj start];
#endif
        }
            break;
        case SLT_ZBar:
        {
#ifdef LBXScan_Define_ZBar
            if (!_zbarObj) {
                
                self.zbarObj = [[LBXZBarWrapper alloc]initWithPreView:videoView barCodeType:[self zbarTypeWithScanType:_scanCodeType] block:^(NSArray<LBXZbarResult *> *result) {
                    
                    //测试，只使用扫码结果第一项
                    LBXZbarResult *firstObj = result[0];
                    
                    LBXScanResult *scanResult = [[LBXScanResult alloc]init];
                    scanResult.strScanned = firstObj.strScanned;
                    scanResult.imgScanned = firstObj.imgScanned;
                    scanResult.strBarCodeType = [LBXZBarWrapper convertFormat2String:firstObj.format];
                    
                    [weakSelf scanResultWithArray:@[scanResult]];
                }];
            }
            [_zbarObj start];
#endif
        }
            break;
        default:
            break;
    }
    
#ifdef LBXScan_Define_UI
    [_qRScanView stopDeviceReadying];
    [_qRScanView startScanAnimation];
#endif
    
    self.view.backgroundColor = [UIColor clearColor];
    [self addSomeSubviews];

}

#ifdef LBXScan_Define_ZBar
- (zbar_symbol_type_t)zbarTypeWithScanType:(SCANCODETYPE)type
{
    //test only ZBAR_I25 effective,why
    return ZBAR_I25;
    
    //    switch (type) {
    //        case SCT_QRCode:
    //            return ZBAR_QRCODE;
    //            break;
    //        case SCT_BarCode93:
    //            return ZBAR_CODE93;
    //            break;
    //        case SCT_BarCode128:
    //            return ZBAR_CODE128;
    //            break;
    //        case SCT_BarEAN13:
    //            return ZBAR_EAN13;
    //            break;
    //
    //        default:
    //            break;
    //    }
    //
    //    return (zbar_symbol_type_t)type;
}
#endif



- (void)stopScan
{
    switch (_libraryType) {
        case SLT_Native:
        {
#ifdef LBXScan_Define_Native
            [_scanObj stopScan];
#endif
        }
            break;
        case SLT_ZXing:
        {
#ifdef LBXScan_Define_ZXing
            [_zxingObj stop];
#endif
        }
            break;
        case SLT_ZBar:
        {
#ifdef LBXScan_Define_ZBar
            [_zbarObj stop];
#endif
        }
            break;
        default:
            break;
    }
    
}

#pragma mark -扫码结果处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    //设置了委托的处理
    if (_delegate) {
        [_delegate scanResultWithArray:array];
    }
    
    //也可以通过继承LBXScanViewController，重写本方法即可
}



//开关闪光灯
- (void)openOrCloseFlash
{
    
    switch (_libraryType) {
        case SLT_Native:
        {
#ifdef LBXScan_Define_Native
            [_scanObj changeTorch];
#endif
        }
            break;
        case SLT_ZXing:
        {
#ifdef LBXScan_Define_ZXing
            [_zxingObj openOrCloseTorch];
#endif
        }
            break;
        case SLT_ZBar:
        {
#ifdef LBXScan_Define_ZBar
            [_zbarObj openOrCloseFlash];
#endif
        }
            break;
        default:
            break;
    }
    self.isOpenFlash =!self.isOpenFlash;
    self.lapBt.selected =  self.isOpenFlash;
}


#pragma mark --打开相册并识别图片

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto:(BOOL)allowsEditing
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    //部分机型有问题
    picker.allowsEditing = allowsEditing;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}



//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    switch (_libraryType) {
        case SLT_Native:
        {
#ifdef LBXScan_Define_Native
            if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
            {
                [LBXScanNative recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
                    [weakSelf scanResultWithArray:array];
                }];
            }
            else
            {
                [self showError:@"native低于ios8.0系统不支持识别图片条码"];
            }
#endif
        }
            break;
        case SLT_ZXing:
        {
#ifdef LBXScan_Define_ZXing
            
            [ZXingWrapper recognizeImage:image block:^(ZXBarcodeFormat barcodeFormat, NSString *str) {
                
                LBXScanResult *result = [[LBXScanResult alloc]init];
                result.strScanned = str;
                result.imgScanned = image;
                result.strBarCodeType = [self convertZXBarcodeFormat:barcodeFormat];
                
                [weakSelf scanResultWithArray:@[result]];
            }];
#endif
            
        }
            break;
        case SLT_ZBar:
        {
#ifdef LBXScan_Define_ZBar
            [LBXZBarWrapper recognizeImage:image block:^(NSArray<LBXZbarResult *> *result) {
                
                //测试，只使用扫码结果第一项
                LBXZbarResult *firstObj = result[0];
                
                LBXScanResult *scanResult = [[LBXScanResult alloc]init];
                scanResult.strScanned = firstObj.strScanned;
                scanResult.imgScanned = firstObj.imgScanned;
                scanResult.strBarCodeType = [LBXZBarWrapper convertFormat2String:firstObj.format];
                
                [weakSelf scanResultWithArray:@[scanResult]];
                
            }];
#endif
            
        }
            break;
            
        default:
            break;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#ifdef LBXScan_Define_ZXing
- (NSString*)convertZXBarcodeFormat:(ZXBarcodeFormat)barCodeFormat
{
    NSString *strAVMetadataObjectType = nil;
    
    switch (barCodeFormat) {
        case kBarcodeFormatQRCode:
            strAVMetadataObjectType = AVMetadataObjectTypeQRCode;
            break;
        case kBarcodeFormatEan13:
            strAVMetadataObjectType = AVMetadataObjectTypeEAN13Code;
            break;
        case kBarcodeFormatEan8:
            strAVMetadataObjectType = AVMetadataObjectTypeEAN8Code;
            break;
        case kBarcodeFormatPDF417:
            strAVMetadataObjectType = AVMetadataObjectTypePDF417Code;
            break;
        case kBarcodeFormatAztec:
            strAVMetadataObjectType = AVMetadataObjectTypeAztecCode;
            break;
        case kBarcodeFormatCode39:
            strAVMetadataObjectType = AVMetadataObjectTypeCode39Code;
            break;
        case kBarcodeFormatCode93:
            strAVMetadataObjectType = AVMetadataObjectTypeCode93Code;
            break;
        case kBarcodeFormatCode128:
            strAVMetadataObjectType = AVMetadataObjectTypeCode128Code;
            break;
        case kBarcodeFormatDataMatrix:
            strAVMetadataObjectType = AVMetadataObjectTypeDataMatrixCode;
            break;
        case kBarcodeFormatITF:
            strAVMetadataObjectType = AVMetadataObjectTypeITF14Code;
            break;
        case kBarcodeFormatRSS14:
            break;
        case kBarcodeFormatRSSExpanded:
            break;
        case kBarcodeFormatUPCA:
            break;
        case kBarcodeFormatUPCE:
            strAVMetadataObjectType = AVMetadataObjectTypeUPCECode;
            break;
        default:
            break;
    }
    
    
    return strAVMetadataObjectType;
}
#endif


- (NSString*)nativeCodeWithType:(SCANCODETYPE)type
{
    switch (type) {
        case SCT_QRCode:
            return AVMetadataObjectTypeQRCode;
            break;
        case SCT_BarCode93:
            return AVMetadataObjectTypeCode93Code;
            break;
        case SCT_BarCode128:
            return AVMetadataObjectTypeCode128Code;
            break;
        case SCT_BarCodeITF:
            return @"ITF条码:only ZXing支持";
            break;
        case SCT_BarEAN13:
            return AVMetadataObjectTypeEAN13Code;
            break;
            
        default:
            return AVMetadataObjectTypeQRCode;
            break;
    }
}

- (void)showError:(NSString*)str
{
    
}

- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });
                                             
                                         }];
            }
                break;
                
        }
    }
    
    
}

+ (BOOL)photoPermission
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        
        if ( author == ALAuthorizationStatusDenied ) {
            
            return NO;
        }
        return YES;
    }
    
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    if ( authorStatus == PHAuthorizationStatusDenied ) {
        
        return NO;
    }
    return YES;
}




@end
