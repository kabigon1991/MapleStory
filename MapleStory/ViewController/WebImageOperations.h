//
//  WebImageOperations.h
//  MapleStory
//
//  Created by Thien Thanh on 9/8/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebImageOperations : NSObject

// This takes in a string and imagedata object and returns imagedata processed on a background thread
+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage;

@end
