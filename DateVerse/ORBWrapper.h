//
//  ORBWrapper.h
//  DateVerse
//
//  Created by 游哲維 on 2025/3/7.
//

#if !TARGET_OS_SIMULATOR

#ifndef ORBWrapper_h
#define ORBWrapper_h

#import <UIKit/UIKit.h>

#ifdef NO
#undef NO
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ORBWrapper : NSObject

- (NSArray<NSValue *> *)detectFeaturesInImage:(UIImage *)image maxFeatures:(int)maxFeatures;

@end

NS_ASSUME_NONNULL_END

#endif /* ORBWrapper_h */

#endif
