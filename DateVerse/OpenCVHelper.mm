//
//  OpenCVHelper.m
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

#import <TargetConditionals.h>

#if !TARGET_OS_SIMULATOR

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef NO
#undef NO
#endif

#import "OpenCVHelper.h"
#import <opencv2/opencv.hpp>

@implementation OpenCVHelper

+ (cv::Mat)cvMatFromUIImage:(UIImage *)image {
    // 1. 從 UIImage 取得 CGImage
    CGImageRef imageRef = image.CGImage;
    if (!imageRef) {
        return cv::Mat();
    }
    
    // 2. 取得影像尺寸
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // 3. 建立顏色空間
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 4. 為影像建立一個緩衝區（4 bytes per pixel：RGBA）
    cv::Mat mat = cv::Mat((int)height, (int)width, CV_8UC4); // CV_8UC4 表示 8-bit unsigned, 4 channels
    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    width,
                                                    height,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    
    if (!contextRef) {
        return cv::Mat();
    }
    
    // 5. 將 CGImage 畫入 context
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(contextRef);
    
    // 如果你需要 BGR 格式，可以再轉換一下：
    cv::Mat matBGR;
    cv::cvtColor(mat, matBGR, cv::COLOR_RGBA2BGR);
    
    return matBGR;
}

@end

#endif
