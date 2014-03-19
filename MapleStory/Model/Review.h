//
//  Review.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Review : JSONModel

@property (nonatomic , strong) NSString *UserImage;
@property (nonatomic , strong) NSString *UserName;
@property (nonatomic , assign) double *Rating;
@property (nonatomic , strong) NSString *Text;
@property (nonatomic , strong) NSString *ReviewDate;

@property (nonatomic , strong) NSMutableArray *Photos;
@property (nonatomic , assign) int *FeedbackCount;



@end
