//
//  OpenCVWrapper.h
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

#if !TARGET_OS_SIMULATOR

#ifndef OpenCVWrapper_h
#define OpenCVWrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef NO
#undef NO
#endif

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject
+ (NSArray<NSValue *> *)detectORBKeypointsInImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END

#endif /* OpenCVWrapper_h */

#endif
