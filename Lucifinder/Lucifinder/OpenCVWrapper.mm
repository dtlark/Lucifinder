//
//  OpenCVWrapper.m
//  Lucifinder
//
//  Created by Jeremy Palavecino on 12/5/20.
//

#import <Foundation/Foundation.h>
#import "OpenCVWrapper.h"
#import "opencv-imageProc.hpp"

@implementation OpenCVWrapper

- (int) imageProc: (const char*) imageUrl{
    std::string filePath(imageUrl);
    int detection = imageProc(filePath);
    return detection;
}

- (int) imageProc2: (UIImage *) image{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4);//8 bits per channel, color channels + alpha
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    cvMat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    int detection = imageProc2(cvMat);
    
    return detection;
}

@end
