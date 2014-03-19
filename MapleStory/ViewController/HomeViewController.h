//
//  HomeViewController.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellServiceTypeCell.h"
#import "ListBusinessesViewController.h"

#import "Common.h"



@interface HomeViewController : UIViewController
{
    //  nearby curent and upcoming discounts
    __weak IBOutlet UILabel *lblNearbyCurrent;
    __weak IBOutlet UILabel *lblNearbyCurrentName;
    __weak IBOutlet UILabel *lblNearbyCurrentInfo;
    __weak IBOutlet UILabel *lblNearbyCurrentAddress;
    __weak IBOutlet UIImageView *imageNearbyDiscount;
    
    //  nearby businesses
    __weak IBOutlet UILabel *lblNearbyBusinesses;
    __weak IBOutlet UILabel *lblNearbyBusinessesName;
    __weak IBOutlet UILabel *lblNearbyBusinessesAddress;
    __weak IBOutlet UILabel *lblNearbyBusinessesInfo;
    __weak IBOutlet UIImageView *imageNearbyBusiness;
    
    //  table list Type Business
    __weak IBOutlet UITableView *tableViewTypeBusiness;
}

- (IBAction)btn_PushToListBusinesses_Clicked:(id)sender;


@end
