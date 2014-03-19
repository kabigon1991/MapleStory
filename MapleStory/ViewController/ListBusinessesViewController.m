//
//  ListBusinessesViewController.m
//  MapleStory
//
//  Created by Thien Thanh on 9/19/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import "ListBusinessesViewController.h"

@interface ListBusinessesViewController ()
{
    NSMutableArray *listNearbyDiscount,*listNearbyBusiness;
    
    //  Google Map
    CLLocationManager *locationManager;
    CLLocation *locationUser;
    
    
    //  Direction
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    GMSPolyline *polyline;
    
    //int currenDist;
    //CLLocationCoordinate2D currentCentre;
    //NSArray* places;
}
@end

@implementation ListBusinessesViewController
@synthesize serviceType;

/********************************************************************************/
#pragma mark  ViewDidLoad


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/** Register notification center for view controller */
-(void) registerNotification
{
    
}


/** Set data when view did load.
 ** Be there. You can set up some variables, data, or any thing that have reletive to data type*/
-(void) setDataWhenViewDidLoad
{
    
    
    //  Create Loading while loading data from server
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationZoom;
    hud.labelText = @"Loading...";
    //  Load Data Service Type  From Server and Load data for Table
    [hud showAnimated:YES whileExecutingBlock:^(void){
        //  load list nearby discount
        [self loadDataNearbyCurrentAndUpComingDiscounts];
        
        //  load list nearby business
        [self loadDataNearbyBusinesses];
        
    }completionBlock:^(void){
        [tableViewNearbyDiscount reloadData];
        
        [tableViewNearbyBusinesses reloadData];
    }];
}


/** Set view when view did load
 ** Be there. You can change the layout, view, button,..*/
-(void) setViewWhenViewDidLoad
{
    lblServiceType.text = serviceType;
}


/** Begin view controller */
- (void)viewDidLoad
{
    [self registerNotification];
    [self setViewWhenViewDidLoad];
    [self setDataWhenViewDidLoad];
    
    [super viewDidLoad];
}


-(void) viewWillAppear:(BOOL)animated
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    lblServiceType = nil;
    listBusinesses = nil;
    [super viewDidUnload];
}

/********************************************************************************/


#pragma mark -
#pragma mark -------------------- Table View -----------------------


/********************************************************************************/
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  table nearby discount
    if (tableView == tableViewNearbyBusinesses)
    {
        return [listNearbyDiscount count];
    }
    //  table nearby businesses
    else
    {
        return [listNearbyBusiness count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCellBusinessCell";
    
    
    CustomCellBusinessCell *cell = (CustomCellBusinessCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        //  CustomCellBusinessCell
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellBusinessCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Nearby *nearby = nil;
    
    //  table nearby discount
    if (tableView == tableViewNearbyBusinesses)
    {
        nearby = listNearbyDiscount[indexPath.row];
    }
    //  table nearby businesses
    else
    {
        nearby = listNearbyBusiness[indexPath.row];
    }
    
    //  load data for cell Business
    cell.lblBusinessName.text = nearby.BusinessName;
    cell.lblBusinessAddress.text = nearby.Address;
    cell.lblBusinessDescription.text = nearby.DiscountDescription;
    
    //  load image Business From Server
    //  url image Service Type
    NSString *urlImage = [NSString stringWithFormat:@"%@/%@",kLinkServerAPI,nearby.EndUserImage];
    [Common loadImage:urlImage andImageView:cell.imageBusiness];
    
    
    return cell;
}


/********************************************************************************/


/********************************************************************************/
#pragma mark UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


/********************************************************************************/



#pragma mark -
#pragma mark -------------------- Nearby Current & upcoming discounts -----------------------

/********************************************************************************/
#pragma mark Load Data Nearby Current Discount

-(void)loadDataNearbyCurrentAndUpComingDiscounts
{
    NSData * jsonData = [Common fetchJSON:[NSString stringWithFormat:@"%@/5?lat=%@ &lon=%@",kAPINearbyDiscount,kLatitudeTest,kLongtitude]];
    
    //  get message from server
    NSString *messageFromServer = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //  if server isn't response data don't do and return
    if ([messageFromServer rangeOfString:@"No HTTP resource was found"].location != NSNotFound) {
        return;
    }
    
    //  load data
    if (jsonData != nil)
    {
        //  init array
        if (!listNearbyDiscount)
        {
            listNearbyDiscount = [NSMutableArray new];
        }
        
        Nearby *nearbyModel = [Nearby new];
        listNearbyDiscount = [nearbyModel getListNearby:jsonData];
        nearbyModel = nil;
    }
    
}

/********************************************************************************/



#pragma mark -
#pragma mark -------------------- Nearby Businesses -----------------------

/********************************************************************************/
#pragma mark Load Data Nearby Businesses


-(void)loadDataNearbyBusinesses
{
    NSData * jsonData = [Common fetchJSON:[NSString stringWithFormat:@"%@/5?lat=%@ &lon=%@",kAPINearbyBusiness,kLatitudeTest,kLongtitude]];
    
    //  get message from server
    NSString *messageFromServer = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //  if server isn't response data don't do and return
    if ([messageFromServer rangeOfString:@"No HTTP resource was found"].location != NSNotFound) {
        return;
    }
    
    //  load data
    if (jsonData != nil)
    {
        //  init array
        if (!listNearbyBusiness)
        {
            listNearbyBusiness = [NSMutableArray new];
        }
        
        Nearby *nearbyModel = [Nearby new];
        listNearbyBusiness = [nearbyModel getListNearby:jsonData];
        nearbyModel = nil;
    }
}



/********************************************************************************/


#pragma mark -
#pragma mark -------------------- Google Map -----------------------

/********************************************************************************/
#pragma mark Add Google Map For View


-(void)addGoogleMapToView
{
    //  Google Map
    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    locationUser = locationManager.location;
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationUser.coordinate.latitude longitude:locationUser.coordinate.longitude zoom:15];
    mapViewGoogle = [GMSMapView mapWithFrame:viewMap.bounds camera:camera];
    [mapViewGoogle setBackgroundColor:[UIColor clearColor]];
    
    mapViewGoogle.myLocationEnabled = YES;
    //mapViewGoogle.indoorEnabled = YES;
    mapViewGoogle.delegate = self;

    [viewMap insertSubview:mapViewGoogle atIndex:0];
    
    // 1 - Remove any existing custom annotations but not the user location blue dot.
    for (GMSMarker *marker in mapViewGoogle.markers)
    {
        [marker setMap:nil];
    }
    
//    for (GMSPolyline *polyline in mapViewGoogle.polylines)
//    {
//        [polyline setStrokeWidth:0];
//    }
    
    //  Nearby Businesses
    [self plotPositions:listNearbyBusiness];
    
    //  Nearby Discount
    [self plotPositions:listNearbyDiscount];
    
    if (!waypoints_)
    {
        waypoints_ = [NSMutableArray new];
    }
    
    if (!waypointStrings_)
    {
        waypointStrings_ = [NSMutableArray new];
    }
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(locationUser.coordinate.latitude,locationUser.coordinate.longitude);
                                                                
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.map = mapViewGoogle;
    [waypoints_ addObject:marker];
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",locationUser.coordinate.latitude,locationUser.coordinate.longitude];
    [waypointStrings_ addObject:positionString];
}


/********************************************************************************/


/********************************************************************************/
#pragma mark Bussiness Point Nearby 


-(void)plotPositions:(NSArray *)data
{
    // 2 - Loop through the array of places returned from the Google API.
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Do something
        //Retrieve the object Business in each index of the array.
        Nearby *nearbyPoint = obj;
        
        // 3 - There is a specific NSDictionary object that gives us the location info.
        // NSDictionary *geo = [place objectForKey:@"ServiceGroupID"];
        // Get the lat and long for the location.
        //NSDictionary *loc = [geo objectForKey:@"ServiceTypeId"];
        // 4 - Get your name and address info for adding to a pin.
        NSString *name = nearbyPoint.BusinessName;
        NSString *vicinity = nearbyPoint.Address;
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        // Set the lat and long.
        placeCoord.latitude = [nearbyPoint.Longtitude doubleValue];
        placeCoord.longitude= [nearbyPoint.Latitude doubleValue];
        
        // 5 - Create a new annotation.
        MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(placeObject.coordinate.latitude, placeObject.coordinate.longitude);
        [marker setUserData:placeObject];
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        marker.icon = [UIImage imageNamed:@"maker-Icon.png"];
        marker.map = mapViewGoogle;
        marker.animated = YES;
    }];
}

/********************************************************************************/


/********************************************************************************/
#pragma mark Direction Between Point Location Current User To Point Business Nearby


/**
 * Called after a marker has been tapped.
 *
 * @param mapView The map view that was pressed.
 * @param marker The marker that was pressed.
 * @return YES if this delegate handled the tap event, which prevents the map
 *         from performing its default selection behavior, and NO if the map
 *         should continue with its default selection behavior.
 */
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    
    if ([waypoints_ count] == 2)
    {
        [waypoints_ removeLastObject];
        [waypointStrings_ removeLastObject];
    }
    
    CLLocationCoordinate2D position = marker.position;

    [waypoints_ addObject:marker];
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",position.latitude,position.longitude];
    
    [waypointStrings_ addObject:positionString];
    
    if([waypoints_ count]>1)
    {
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                               nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                          forKeys:keys];
        MDDirectionService *mds = [[MDDirectionService alloc] init];
        SEL selector = @selector(addDirections:);
        [mds setDirectionsQuery:query withSelector:selector withDelegate:self];
    }
    
    return YES;
}

/********************************************************************************/


/********************************************************************************/
#pragma mark Add Direction On Map


- (void)addDirections:(NSDictionary *)json
{
    
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    
    //  clear polylines 
    [polyline setMap:nil];
    
    //  create new polylines
    polyline = [GMSPolyline polylineWithPath:path];
    
    //  Property
    [polyline setStrokeWidth:5.0f];
    [polyline setTitle:@"Direction"];
    [polyline setGeodesic:YES];
    [polyline setTappable:YES];
    
    polyline.map = mapViewGoogle;
}


/********************************************************************************/


#pragma mark -
#pragma mark -------------------- IBAction -----------------------

/********************************************************************************/
#pragma mark Show List Businesses

- (IBAction)btn_ShowListBusinesses_Clicked:(id)sender
{
    //  show List Businesses
    [listBusinesses setHidden:NO];
    [viewMap setHidden:YES];
}

/********************************************************************************/


/********************************************************************************/
#pragma mark Show Map


- (IBAction)btn_ShowMap_Clicked:(id)sender
{
    //  create Map
    if (!mapViewGoogle)
    {
        [self addGoogleMapToView];
    }

    //  show Map
    [viewMap setHidden:NO];
    [listBusinesses setHidden:YES];
}

/********************************************************************************/



@end
