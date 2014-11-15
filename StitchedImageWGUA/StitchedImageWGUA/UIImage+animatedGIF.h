
//  ...
//
//  Created by JNYJ(William) on 28/3/13.
//  Copyright (c) 2013 JNYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (animatedGIF)

//duration DEPRECATED
+ (NSTimeInterval)animationDurationPath:(NSString *)path;
+ (NSTimeInterval)animationDurationUrl:(NSURL *)url;
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data duration:(NSTimeInterval)duration;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url duration:(NSTimeInterval)duration;

+ (BOOL)imageIsAnimatePath:(NSString *)path;
+ (BOOL)imageIsAnimateUrl:(NSURL *)url;
+ (NSArray *)exportAnimatePages:(NSString *)path folder:(NSString *)folder;

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url;

@end
