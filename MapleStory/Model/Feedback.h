//
//  Feedback.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Feedback : JSONModel

@property (nonatomic , strong) NSString *Text;
@property (nonatomic , strong) NSString *EndUserName;
@property (nonatomic , strong) NSString *EndUserImage;
@property (nonatomic , strong) NSString *FeedbackDate;

@end
