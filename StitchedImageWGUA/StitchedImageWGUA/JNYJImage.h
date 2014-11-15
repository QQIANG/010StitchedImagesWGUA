//
//  JNYJImage.h
//  ...
//
//  Created by JNYJ(William) on 28/3/13.
//  Copyright (c) 2013 JNYJ. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface JNYJImage : NSObject

//+(UIImage *)reduceImageFileElement:(id)directoryElement;
+(UIImage *)reduceImageFilePath:(NSString *)filePath;
+(UIImage *)reduceImageWithUIImage:(UIImage *)image;
+(void)fitAndFillImageView:(UIView *)view_ image:(UIImage *)image;
@end
