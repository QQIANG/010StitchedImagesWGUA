//
//  JNYJStitchedImages.h
//  StitchedImageWGUA
//
//  Created by JNYJ on 14-11-15.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNYJStitchedImages : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect rect_first;

+(JNYJStitchedImages *)shareJNYJStitchedImages;


- (UIImage *)stitchedImageWithSize:(CGSize)size
					  borderOffset:(CGFloat)borderOffset
					   borderColor:(UIColor *)borderColor;
@end
