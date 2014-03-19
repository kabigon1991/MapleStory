//
//  Nearby.m
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import "Nearby.h"

@implementation Nearby

@synthesize EndUserID;
@synthesize EndUserImage;
@synthesize CityID;
@synthesize BusinessName;
@synthesize Address;
@synthesize ServiceTypeName;
@synthesize Latitude;
@synthesize Longtitude;
@synthesize DistanceFromCurrent;
@synthesize Rating;
@synthesize ReviewNumber;
@synthesize DiscountDescription;


/********************************************************************************/
#pragma mark Get Data


-(NSMutableArray *)getDataNearby:(NSData *)jsonData
{
    NSError *error;
    NSArray *parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    __block Nearby *nearby = nil;
    NSMutableArray *dataFromServer = [NSMutableArray new];
    
    [parsedData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSError *error;
        // Pass 0 if you don't care about the readability of the generated string
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        
        //  parse data to object nearby
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        nearby = [[Nearby alloc]initWithString:json error:nil];
        
        //  add object to array
        [dataFromServer addObject:nearby];
    }];
    
    return dataFromServer;
    
}


/********************************************************************************/


/********************************************************************************/
#pragma mark Get Top Nearby

-(Nearby *)getTopNearby:(NSData *)jsonData
{
    //  get data
    NSArray *array = [self getDataNearby:jsonData];
    
    //  check data is exist
    if ([array count] != 0)
    {
        return array[0];
    }
    return nil;
}

/********************************************************************************/


/********************************************************************************/
#pragma mark Get List Nearby

-(NSMutableArray *)getListNearby:(NSData *)jsonData
{
    //  get data
    return [self getDataNearby:jsonData];
}

/********************************************************************************/

@end
