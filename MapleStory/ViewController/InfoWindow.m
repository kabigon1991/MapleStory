//
//  InfoWindow.m
//  GoogleMapSDK
//
//  Created by Thien Thanh on 8/6/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import "InfoWindow.h"

@interface InfoWindow ()

@end

@implementation InfoWindow
@synthesize nameLocation;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [titleLabel setText:nameLocation];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
