//
//  CustomCellBusinessCell.m
//  MapleStory
//
//  Created by Thien Thanh on 9/19/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import "CustomCellBusinessCell.h"

@implementation CustomCellBusinessCell
@synthesize lblBusinessAddress;
@synthesize lblBusinessDescription;
@synthesize lblBusinessName;
@synthesize imageBusiness;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
