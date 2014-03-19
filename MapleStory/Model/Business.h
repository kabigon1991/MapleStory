//
//  Business.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Business : JSONModel

@property (nonatomic , strong) NSString *EndUserID;
@property (nonatomic , strong) NSString *EndUserImage;
@property (nonatomic , strong) NSString *CityName;
@property (nonatomic , strong) NSString *StateName;
@property (nonatomic , strong) NSString *BusinessName;
@property (nonatomic , strong) NSString *Address;
@property (nonatomic , strong) NSString *ZipCode;
@property (nonatomic , strong) NSString *CellPhone;
@property (nonatomic , strong) NSString *FixedPhone;
@property (nonatomic , strong) NSString *Email;

@property (nonatomic , strong) NSString *ServiceTypeName;
@property (nonatomic , assign) double *Latitude;
@property (nonatomic , assign) double *Longtitude;
@property (nonatomic , assign) double *DistanceFromCurrent;
@property (nonatomic , assign) double *Rating;
@property (nonatomic , assign) int *ReviewNumber;

@property (nonatomic , strong) NSMutableArray *Photos;
@property (nonatomic , strong) NSMutableArray *Reviews;
@property (nonatomic , strong) NSMutableArray *Services;
@property (nonatomic , strong) NSMutableArray *Discounts;

@end
