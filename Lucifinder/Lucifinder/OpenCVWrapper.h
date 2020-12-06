//
//  OpenCVWrapper.h
//  Lucifinder
//
//  Created by Jeremy Palavecino on 12/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

- (int) imageProc: (const char*) imageUrl;
- (int) imageProc2: (UIImage *) image;

@end
