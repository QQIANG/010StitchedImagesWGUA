//
//  LargeImageView.h
//  ...
//
//  Created by JNYJ(William) on 28/3/13.
//  Copyright (c) 2013 JNYJ. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LargeImageView : UIScrollView <UIScrollViewDelegate>

@property (strong, nonatomic) NSString *imgPath;

- (id)initWithFrame:(CGRect)frame;
@end
