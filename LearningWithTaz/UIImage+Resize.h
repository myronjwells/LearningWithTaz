//
//  UIImage+Resize.h
//
//  Created by Myron  J. Wells on 1/10/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Resize)

- (UIImage*)resizedImageWithSize:(CGSize)size;
- (UIImage*)cropImageFromFrame:(CGRect)frame;

@end
