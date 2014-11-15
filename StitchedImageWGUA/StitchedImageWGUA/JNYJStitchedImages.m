//
//  JNYJStitchedImages.m
//  StitchedImageWGUA
//
//  Created by JNYJ on 14-11-15.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//

#import "UIImage+largeImage.h"
#import "JNYJStitchedImages.h"
#import "JNYJImage.h"

static  JNYJStitchedImages *_static_obj = nil;

@implementation JNYJStitchedImages

+(JNYJStitchedImages *)shareJNYJStitchedImages{
	if (_static_obj){
	}else{
		_static_obj = [[JNYJStitchedImages alloc] init];
		_static_obj.frame = CGRectMake(0, 0, 320, 480);
	}
	return _static_obj;
}

- (UIImage *)stitchedImageWithSize:(CGSize)size
					  borderOffset:(CGFloat)borderOffset
					   borderColor:(UIColor *)borderColor
{

	UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, size.width, size.height)];
	v.backgroundColor = self.backgroundColor;
//	v.image = self.image;
	v.contentMode = self.contentMode;

	for (NSUInteger i = 0; i < self.subviews.count; i++) {
		id obj = self.subviews[i];

		if ([obj isKindOfClass:[JNYJStitchedImages class]]) {
			JNYJStitchedImages *cell = obj;


			CGRect rect = cell.frame;

			[JNYJImage fitAndFillImageView:cell image:cell.image];


			CGRect rect_s = cell.frame;

			if (cell.image) {
				UIView *sv = [[UIView alloc] initWithFrame:CGRectMake(
																	  rect.origin.x+rect_s.origin.x,
																	  rect.origin.y+rect_s.origin.y,
																	  rect.size.width+(borderOffset*2),
																	  rect.size.height+(borderOffset*2))];
				sv.backgroundColor = borderColor;

				CGSize tmpsize = cell.frame.size;
				UIImage *img = [UIImage imageWithImage:cell.image inRect:CGRectZero
												  size:&tmpsize errMsg:nil];
				UIImageView *vimg = [[UIImageView alloc] initWithFrame:CGRectMake(
																				  borderOffset,
																				  borderOffset,
																				  rect.size.width,
																				  rect.size.height)];
				vimg.image = img;
				[sv addSubview:vimg];

				[v addSubview:sv];
				sv.transform = cell.transform;
			}
		}
	}

	UIGraphicsBeginImageContext(size);
	CGContextRef contxt = UIGraphicsGetCurrentContext();
	[v.layer renderInContext:contxt];
	UIImage *des = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return des;
}
@end
