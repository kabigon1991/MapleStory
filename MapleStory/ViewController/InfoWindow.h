//
//  InfoWindow.h
//  GoogleMapSDK
//
//  Created by Thien Thanh on 8/6/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoWindow : UIViewController
{
    __weak IBOutlet UILabel *titleLabel;
    NSString *nameLocation;
}

@property (nonatomic,strong) NSString *nameLocation;

@end
