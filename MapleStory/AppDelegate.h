//
//  AppDelegate.h
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@class HomeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
}

@property (readonly) UINavigationController *navigationController;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HomeViewController *viewController;

@end
