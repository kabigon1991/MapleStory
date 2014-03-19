//
//  HomeViewController.m
//  MapleStory
//
//  Created by Thien Thanh on 9/3/13.
//  Copyright (c) 2013 Thien Thanh. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    ServiceType *serviceType;
    Nearby *nearby,*nearbyModel;
    NSMutableArray *parseArray;
}

@end

@implementation HomeViewController



#pragma mark -
#pragma mark -------------------- Lifecycle -----------------------
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
    nearbyModel = [Nearby new];
    
    [tableViewTypeBusiness reloadData];
    
    //  nearby current and comingup discounts
    [self loadDataNearbyCurrentAndUpComingDiscounts];
    
    //  nearby bussiness
    [self loadDataNearbyBusinesses];
    
    //  Create Loading while loading data from server
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationZoom;
    hud.labelText = @"Loading..."; 
    //  Load Data Service Type  From Server and Load data for Table
    [hud showAnimated:YES whileExecutingBlock:^(void){        
        //  list BusinessType
        [self loadDataServiceTypeForTable];
    }completionBlock:^(void){
        [tableViewTypeBusiness reloadData];
    }];
    
}


/** Set view when view did load
 ** Be there. You can change the layout, view, button,..*/
-(void) setViewWhenViewDidLoad
{
    //  set font
    for(UIView *view in [self.view subviews])
    {
        if([view isKindOfClass:[UILabel class]])
        {
            [(UILabel *)view setFont:[Common fontAllApp]];
        }
    }
    
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
    imageNearbyDiscount = nil;
    imageNearbyBusiness = nil;
    [super viewDidUnload];
}


/********************************************************************************/


#pragma mark -
#pragma mark -------------------- Data For Table -----------------------
/********************************************************************************/
#pragma mark Load Data Service Type For Table


- (void)loadDataServiceTypeForTable
{
    //NSString *json = [self fetchJSON:@"api/NearbyBusiness/5?lat=109.189294 &lon=12.239149"];
    NSData * jsonData = [Common fetchJSON:kAPIServiceType];
    
    //  get message from server
    NSString *messageFromServer = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //  if server isn't response data don't do and return
    if ([messageFromServer rangeOfString:@"No HTTP resource was found"].location != NSNotFound) {
        return;
    }
    
    //  if data != nil
    if (jsonData != nil)
    {
        NSError *error;
        NSArray *parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        parseArray = [NSMutableArray new];
        
        [parsedData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            // Do something
            NSError *error;
            // Pass 0 if you don't care about the readability of the generated string
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
            
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            serviceType = nil;
            serviceType = [[ServiceType alloc]initWithString:json error:nil];
            [parseArray addObject:serviceType];            
        }];
    }
}



/********************************************************************************/


#pragma mark -
#pragma mark -------------------- Talbe Service Type -----------------------
/********************************************************************************/
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [parseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCellServiceTypeCell";
    
    CustomCellServiceTypeCell *cell = (CustomCellServiceTypeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        //  Custom
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        //  Default
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    //  Object Service Type
    serviceType = parseArray[indexPath.row];
    
    //  show data to cell
    //  Service Name
    cell.lbl_ServiceType.text = serviceType.ServiceTypeName;
    
    //  Icon Service Image
    //  if cell hasn't image load from server
    
    //  check image is downloaded in Folder ImageServiceType
    NSString *path = [NSString stringWithFormat:@"/%@/%@",kFolderImageServiceType,serviceType.ServiceTypeImage];
    NSString *pathSaveImage = [Common documentsPathForFileName:path];
    NSData *jpgData = [NSData dataWithContentsOfFile:pathSaveImage];
    
    //  if image isn't exist download from server
    if (jpgData == nil)
    {
        //  url image Service Type
        NSString *urlImage = [NSString stringWithFormat:@"%@/%@",kLinkServerAPI, serviceType.ServiceTypeImage];
        
        //  load image from server
        [WebImageOperations processImageDataWithURLString:urlImage andBlock:^(NSData *imageData) {
            if (self.view.window)
            {
                //  show icon 
                UIImage *image = [UIImage imageWithData:imageData];
                NSData *jpgData = UIImageJPEGRepresentation(image, 0.5);
                
                //  save image when download from server to use same object                
                //  save image to path
                [jpgData writeToFile:pathSaveImage atomically:YES];
                
                [cell.img_IconServiceType setImage:image];
            }
            
        }];

    }
    //  get from folder ImageServiceType
    else
    {
        UIImage *image = [UIImage imageWithData:jpgData];
        [cell.img_IconServiceType setImage:image];
    }
    
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
#pragma mark Load Data Nearby Current

-(void)loadDataNearbyCurrentAndUpComingDiscounts
{
    NSData * jsonData = [Common fetchJSON:[NSString stringWithFormat:@"%@/?lat=%@ &lon=%@",kAPINearbyDiscount,kLatitudeTest,kLongtitude]];
    
    //  get message from server
    NSString *messageFromServer = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //  if server isn't response data don't do and return
    if ([messageFromServer rangeOfString:@"No HTTP resource was found"].location != NSNotFound) {
        return;
    }

    //  load data
    if (jsonData != nil)
    {
        nearby = [nearbyModel getTopNearby:jsonData];
        
        //  show in view
        lblNearbyCurrentName.text = nearby.BusinessName;
        lblNearbyCurrentAddress.text = nearby.Address;
        lblNearbyCurrentInfo.text = nearby.DiscountDescription;
        
        //  set image
        //  url image Service Type
        NSString *urlImage = [NSString stringWithFormat:@"%@/%@",kLinkServerAPI,nearby.EndUserImage];
        [Common loadImage:urlImage andImageView:imageNearbyDiscount];
    }
    
}

/********************************************************************************/



#pragma mark -
#pragma mark -------------------- Nearby Businesses -----------------------

/********************************************************************************/
#pragma mark Load Data Nearby Businesses


-(void)loadDataNearbyBusinesses
{
    NSData * jsonData = [Common fetchJSON:[NSString stringWithFormat:@"%@/?lat=%@ &lon=%@",kAPINearbyBusiness,kLatitudeTest,kLongtitude]]; 
    
    //  get message from server
    NSString *messageFromServer = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //  if server isn't response data don't do and return
    if ([messageFromServer rangeOfString:@"No HTTP resource was found"].location != NSNotFound) {
        return;
    }
    
    //  Load data
    if (jsonData != nil)
    {
        nearby = [nearbyModel getTopNearby:jsonData];
        
        //  show in view
        lblNearbyBusinessesName.text = nearby.BusinessName;
        lblNearbyBusinessesAddress.text = nearby.Address;
        lblNearbyBusinessesInfo.text = nearby.DiscountDescription;
        
        //  set image
        //  url image Service Type
        NSString *urlImage = [NSString stringWithFormat:@"%@/%@",kLinkServerAPI,nearby.EndUserImage];
        [Common loadImage:urlImage andImageView:imageNearbyBusiness];
    }
}



/********************************************************************************/


#pragma mark -
#pragma mark -------------------- IBAction -----------------------


/********************************************************************************/
#pragma mark Push To List Businesses


- (IBAction)btn_PushToListBusinesses_Clicked:(id)sender
{
    ListBusinessesViewController *listBusinesses = [ListBusinessesViewController new];
    listBusinesses.serviceType = @"A";
    
    [self.navigationController pushViewController:listBusinesses animated:YES];
}

/********************************************************************************/


@end
