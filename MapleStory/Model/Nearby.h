//
//  Nearby.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Nearby : JSONModel

@property (nonatomic,strong) NSString *EndUserID;
@property (nonatomic,strong) NSString *EndUserImage;
@property (nonatomic,strong) NSString *CityID;
@property (nonatomic,strong) NSString *BusinessName;
@property (nonatomic,strong) NSString *Address;
@property (nonatomic,strong) NSString *ServiceTypeName;
@property (nonatomic,strong) NSNumber *Latitude;
@property (nonatomic,strong) NSNumber *Longtitude;
@property (nonatomic,strong) NSNumber *DistanceFromCurrent;
@property (nonatomic,strong) NSNumber *Rating;
@property (nonatomic,strong) NSNumber *ReviewNumber;
@property (nonatomic,strong) NSString *DiscountDescription;


#pragma mark Get List Nearby

-(NSMutableArray *)getListNearby:(NSData *)jsonData;


#pragma mark Get Top Nearby

-(Nearby *)getTopNearby:(NSData *)jsonData;


@end
