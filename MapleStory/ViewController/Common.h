//
//  Common.h
//  MapleStory
//
//  Created by Thien Thanh on 9/9/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebImageOperations.h"
#import "ConfigApp.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "Model.h"

@interface Common : NSObject


//  get path to directory
+(NSString *)documentsPathForFileName:(NSString *)path;

//  create folder
+(void)createFolderWithPath:(NSString *)path;

//  check network
+(BOOL)checkConnectInternetDevice;

//  get data from server
+(NSData *)fetchJSON:(NSString *)str;

//  Font
+(UIFont *)fontAllApp;

//  Load Image From Server
+(void)loadImage:(NSString *)urlImage andImageView:(UIImageView *)imageView;

@end
