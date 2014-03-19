//
//  CustomCellBusinessCell.h
//  MapleStory
//
//  Created by Thien Thanh on 9/19/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellBusinessCell : UITableViewCell
{
     IBOutlet UIImageView *imageBusiness;
     IBOutlet UILabel *lblBusinessName;
     IBOutlet UILabel *lblBusinessAddress;
     IBOutlet UILabel *lblBusinessDescription;
}

@property (nonatomic , strong) IBOutlet UIImageView *imageBusiness;
@property (nonatomic , strong) IBOutlet UILabel *lblBusinessName;
@property (nonatomic , strong) IBOutlet UILabel *lblBusinessAddress;
@property (nonatomic , strong) IBOutlet UILabel *lblBusinessDescription;

@end
