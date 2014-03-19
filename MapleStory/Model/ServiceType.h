//
//  ServiceType.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ServiceType : JSONModel

@property (nonatomic,strong) NSString *ServiceTypeID;
@property (nonatomic,strong) NSString *ServiceTypeName;
@property (nonatomic,strong) NSString *ServiceGroupID;
@property (nonatomic,strong) NSString *ServiceTypeImage;


@end
