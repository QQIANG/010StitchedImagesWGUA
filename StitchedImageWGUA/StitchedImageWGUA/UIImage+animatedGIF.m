
//  ...
//
//  Created by JNYJ(William) on 28/3/13.
//  Copyright (c) 2013 JNYJ. All rights reserved.
//

#import "UIImage+animatedGIF.h"
#import <ImageIO/ImageIO.h>

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#else
#define toCF (CFTypeRef)
#endif

@implementation UIImage (animatedGIF)

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef source) {
    //replace duration with ImageIO function
    if (!source)
        return nil;
    
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    NSTimeInterval time_duration = 0;
    for (size_t i = 0; i < count; ++i) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage)
            return nil;
        
        //get duration with ImageIO but not libgungif
        CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        if (properties) {
            CFDictionaryRef gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
            if (gifProperties) {
                CFNumberRef number = CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                double delay = 0.f;
                CFNumberGetValue(number, kCFNumberDoubleType, &delay);
                delay = lrint(delay * 100.f);
                if (delay > 5.f) {
                    time_duration += delay;
                }
                else {
                    time_duration += 5.f;
                }
            }
            CFRelease(properties);
        }
        
        [images addObject:[UIImage imageWithCGImage:cgImage]];
        CGImageRelease(cgImage);
    }
    
    return [UIImage animatedImageWithImages:images duration:(time_duration / 100.f)];
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef source) {
    UIImage *image = animatedImageWithAnimatedGIFImageSource(source);
    CFRelease(source);
    return image;
}

+ (NSTimeInterval)animationDurationPath:(NSString *)path
{
    return 0.f;
}

+ (NSTimeInterval)animationDurationUrl:(NSURL *)url
{
    return [self animationDurationPath:[url path]];
}

+ (BOOL)imageIsAnimatePath:(NSString *)path {
    return [self imageIsAnimateUrl:[NSURL fileURLWithPath:path]];
}

+ (BOOL)imageIsAnimateUrl:(NSURL *)url {
    CGImageSourceRef source = CGImageSourceCreateWithURL(toCF url, NULL);
    size_t count = CGImageSourceGetCount(source);
    if (count > 1) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data duration:(NSTimeInterval)duration {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url duration:(NSTimeInterval)duration {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

+ (NSArray *)exportAnimatePages:(NSString *)path folder:(NSString *)folder
{
    CGImageSourceRef source = CGImageSourceCreateWithURL(toCF [NSURL fileURLWithPath:path], NULL);
    
    if (!source)
        return nil;
    
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *array = [NSMutableArray array];
    for (size_t i = 0; i < count; ++i) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage) continue;
        UIImage *img = [UIImage imageWithCGImage:cgImage];
        NSData *data = UIImageJPEGRepresentation(img, 0.9);
        
        NSString *fileName = [path lastPathComponent];
        
        if ([data writeToFile:[NSString stringWithFormat:@"%@(%ld).jpg", [folder stringByAppendingPathComponent:[fileName stringByDeletingPathExtension]], i] atomically:YES]) {
            [array addObject:[NSString stringWithFormat:@"%@(%ld).jpg", [folder stringByAppendingPathComponent:[fileName stringByDeletingPathExtension]], i]];
        }
        CGImageRelease(cgImage);
    }
    return array;
}

@end
