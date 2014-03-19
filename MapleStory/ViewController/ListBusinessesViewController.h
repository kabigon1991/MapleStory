//
//  ListBusinessesViewController.h
//  MapleStory
//
//  Created by Thien Thanh on 9/19/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "CustomCellBusinessCell.h"
#import <CoreLocation/CoreLocation.h>
#import "Common.h"
#import "MapPoint.h"
#import "MDDirectionService.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ListBusinessesViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
{
    
    __weak IBOutlet UILabel *lblServiceType;
    
    //  nearby discount
    __weak IBOutlet UITableView *tableViewNearbyDiscount;
    
    //  nearby businesses
    __weak IBOutlet UITableView *tableViewNearbyBusinesses;
    
    //  Google Map
    __weak IBOutlet UIView *viewMap;
    __weak IBOutlet GMSMapView *mapViewGoogle;
    
    //  List Businesses
    __weak IBOutlet UIView *listBusinesses;
    
    
    NSString *serviceType;
}


@property (nonatomic,strong) NSString *serviceType;

- (IBAction)btn_ShowListBusinesses_Clicked:(id)sender;
- (IBAction)btn_ShowMap_Clicked:(id)sender;



@end
