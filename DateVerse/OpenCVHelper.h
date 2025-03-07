//
//  OpenCVHelper.h
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

#if !TARGET_OS_SIMULATOR

#ifndef OpenCVHelper_h
#define OpenCVHelper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef NO
#undef NO
#endif

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVHelper : NSObject

+ (id)cvMatFromUIImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

#endif /* OpenCVHelper_h */

#endif
