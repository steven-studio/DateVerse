//
//  ORBWrapper.m
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

#import <TargetConditionals.h>

#if !TARGET_OS_SIMULATOR

#import <Foundation/Foundation.h>

#ifdef NO
#undef NO
#endif

#import "ORBWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation ORBWrapper

- (NSArray<NSValue *> *)detectFeaturesInImage:(UIImage *)image maxFeatures:(int)maxFeatures {
    cv::Mat matImage;
    UIImageToMat(image, matImage);
    // 如果是彩色圖片，轉成灰階
    if (matImage.channels() > 1) {
        cv::cvtColor(matImage, matImage, cv::COLOR_BGR2GRAY);
    }
    
    // 建立 ORB 檢測器
    cv::Ptr<cv::ORB> orb = cv::ORB::create(maxFeatures);
    std::vector<cv::KeyPoint> keypoints;
    orb->detect(matImage, keypoints);
    
    NSMutableArray<NSValue *> *points = [NSMutableArray array];
    for (const cv::KeyPoint &kp : keypoints) {
        CGPoint point = CGPointMake(kp.pt.x, kp.pt.y);
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    return points;
}

@end

#endif
