//
//  Common.m
//  MapleStory
//
//  Created by Thien Thanh on 9/9/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import "Common.h"

@implementation Common


/********************************************************************************/
#pragma mark -
#pragma mark Path To Directory


+(NSString *)documentsPathForFileName:(NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:path];
    
    return filePath;
}


/********************************************************************************/



/********************************************************************************/
#pragma mark -
#pragma mark Create Folder


+(void)createFolderWithPath:(NSString *)path
{
    NSError *error;
    //Create folder
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
}

/********************************************************************************/


/********************************************************************************/
#pragma mark -
#pragma mark Get Data From Server


+(NSData *)fetchJSON:(NSString *)str
{
    //  check connect internet
    if ([Common checkConnectInternetDevice])
    {
        NSString *s2 = [NSString stringWithFormat:@"%@/%@",kLinkServerAPI, str];
        NSString *strUrl = [s2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url= [NSURL URLWithString:strUrl];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        NSError *err;
        NSURLResponse *response = nil;
        
        NSData *jsonData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&err];
        
        return jsonData;
    }
    else
        return nil;
}



/********************************************************************************/


/********************************************************************************/
#pragma mark -
#pragma mark Check Connect Internet Device


+(BOOL)checkConnectInternetDevice
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
        return NO;
    }
    else
    {
        NSLog(@"There IS internet connection");
        return YES;
    }        
}


/********************************************************************************/



/********************************************************************************/
#pragma mark Set Font

+(UIFont *)fontAllApp
{
    return [UIFont fontWithName:kFont size:kFontSize];
}

/********************************************************************************/


/********************************************************************************/
#pragma mark Load Image From Server

+(void)loadImage:(NSString *)urlImage andImageView:(UIImageView *)imageView
{
    __block UIImage *image = nil;
    //  load image from server
    [WebImageOperations processImageDataWithURLString:urlImage andBlock:^(NSData *imageData) {
            //  show icon
            image = [UIImage imageWithData:imageData];
            [imageView setImage:image];
            //NSData *jpgData = UIImageJPEGRepresentation(image, 0.5);
    }];
}


/********************************************************************************/

@end
