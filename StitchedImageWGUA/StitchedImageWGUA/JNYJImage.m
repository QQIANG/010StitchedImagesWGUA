//
//  JNYJImage.m
//  ...
//
//  Created by JNYJ(William) on 28/3/13.
//  Copyright (c) 2013 JNYJ. All rights reserved.
//

#import "JNYJImage.h"
#import "UIImage+animatedGIF.h"
#import "UIImage+largeImage.h"

//#import "FileManagerBiz.h"

#define LimitImageSize      2048
@implementation JNYJImage
/*
+(UIImage *)reduceImageFileElement:(DirectoryElement *)directoryElement{
    
    NSString *filePath = [NSString stringWithFormat:@"%@",[[FileManagerBiz getRootDecryptFolderPath] stringByAppendingPathComponent:directoryElement.name]];
    UIImage *paramImage = [FileManagerBiz imageWithElement:directoryElement];
    NSUInteger uintPixels = LimitImageSize;
    if ([UIImage imageIsAnimatePath:filePath]) {
        NSTimeInterval duration = [UIImage animationDurationPath:filePath];
        paramImage = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:filePath] duration:duration];
    }
    else if (paramImage.size.width > uintPixels
             || paramImage.size.height > uintPixels) {
        CGSize size = CGSizeMake(uintPixels, uintPixels);
        paramImage = [UIImage imageWithPath:filePath inRect:CGRectZero size:&size errMsg:nil];
    }
    return paramImage;
}
 */
+(UIImage *)reduceImageFilePath:(NSString *)filePath{
    
    UIImage *paramImage = [UIImage imageWithContentsOfFile:filePath];
    NSUInteger uintPixels = LimitImageSize;
    if ([UIImage imageIsAnimatePath:filePath]) {
        NSTimeInterval duration = [UIImage animationDurationPath:filePath];
        paramImage = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:filePath] duration:duration];
    }
    else if (paramImage.size.width > uintPixels
             || paramImage.size.height > uintPixels) {
        CGSize size = CGSizeMake(uintPixels, uintPixels);
        paramImage = [UIImage imageWithPath:filePath inRect:CGRectZero size:&size errMsg:nil];
    }
    return paramImage;
}
+(UIImage *)reduceImageWithUIImage:(UIImage *)image{
    
    UIImage *paramImage = image;
    NSUInteger uintPixels = LimitImageSize;
    if (paramImage.size.width > uintPixels
        || paramImage.size.height > uintPixels) {
        CGSize size = CGSizeMake(uintPixels, uintPixels);
        paramImage = [UIImage imageWithImage:paramImage inRect:CGRectZero size:&size errMsg:nil];
    }
    return paramImage;
}


+(void)fitAndFillImageView:(UIView *)view_ image:(UIImage *)image{

	if (image) {
	}else{
	}
	CGSize paramSize = image.size;
	CGSize paramSelfViewSize = view_.frame.size;
	CGFloat widthScale = view_.frame.size.width/paramSize.width;
	CGFloat heightScale = view_.frame.size.height/paramSize.height;
	CGRect paramRect;
	CGFloat paramWidth;
	CGFloat paramHeight;
	if (widthScale>1 && heightScale >1) {
		paramRect = CGRectMake((paramSelfViewSize.width - paramSize.width)/2, (paramSelfViewSize.height - paramSize.height)/2, paramSize.width ,paramSize.height);
	}else if (widthScale<1 || heightScale<1){
		if (heightScale>=widthScale) {
			paramWidth = paramSize.width*widthScale;
			paramHeight = paramSize.height*widthScale;
			paramRect = CGRectMake((paramSelfViewSize.width - paramWidth)/2, (paramSelfViewSize.height - paramHeight)/2, paramWidth ,paramHeight);
		}else{
			paramWidth = paramSize.width*heightScale;
			paramHeight = paramSize.height*heightScale;
			paramRect = CGRectMake((paramSelfViewSize.width - paramWidth)/2, (paramSelfViewSize.height - paramHeight)/2, paramWidth ,paramHeight);
		}
	}else{
		paramRect = CGRectMake(0,0,paramSelfViewSize.width,paramSelfViewSize.height);
	}
	[view_ setFrame:paramRect];

}

@end
