//
//  OpenCVWrapper.m
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

#import <TargetConditionals.h>

#if !TARGET_OS_SIMULATOR

#import <Foundation/Foundation.h>
#import <UIKIt/UIKit.h>

#ifdef NO
#undef NO
#endif

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/features2d.hpp>

@implementation OpenCVWrapper
+ (NSArray<NSValue *> *)detectORBKeypointsInImage:(UIImage *)image {
    cv::Mat cvImage;
    // Convert UIImage to cv::Mat (這部分需要額外實作)
    // …
    cv::Ptr<cv::ORB> orb = cv::ORB::create();
    std::vector<cv::KeyPoint> keypoints;
    orb->detect(cvImage, keypoints);
    
    NSMutableArray *result = [NSMutableArray array];
    for (const auto &kp : keypoints) {
        CGPoint point = CGPointMake(kp.pt.x, kp.pt.y);
        [result addObject:[NSValue valueWithCGPoint:point]];
    }
    return result;
}
@end

#endif
