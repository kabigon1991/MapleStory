//
//  Photo.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Photo : JSONModel

@property (nonatomic , strong) NSString *PhotoURL;
@property (nonatomic , strong) NSString *ThumbnailURL;
@property (nonatomic , strong) NSString *Description;

@end
