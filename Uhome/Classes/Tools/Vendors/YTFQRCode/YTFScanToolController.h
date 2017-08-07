//
//  Uhome_Header_Bridging.h
//  Uhome
//
//  Created by 程荣刚 on 2017/5/26.
//  Copyright © 2017年 menhao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  相机扫描二维码
 *
 *  @param qrCode 二维码string
 */
typedef void (^QRCodeCameraString)(NSString *qrCode);

/**
 *  解码相册图片
 *
 *  @param qrCode 二维码string
 */
typedef void (^QRCodeAlbumString)(NSString *qrCode);

@interface YTFScanToolController : UIViewController

@property (nonatomic, copy) QRCodeCameraString cameraCodeString; // 相机扫描二维码
@property (nonatomic, copy) QRCodeAlbumString albumCodeString; // 解码相册图片

/**
 *  判断相机摄像头可用状态
 */
- (BOOL)isCameraAllowed;

/**
 * 判断权限
 */
- (BOOL)isCameraValid;

@end
