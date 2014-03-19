//
//  Service.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Service : JSONModel

@property (nonatomic , strong) NSString *ServiceID;
@property (nonatomic , strong) NSString *ServiceName;
@property (nonatomic , strong) NSString *Note;
@property (nonatomic , strong) NSString *Price;
@property (nonatomic , strong) NSString *ServiceImage;

@property (nonatomic , strong) NSMutableArray *Photos;


@end
