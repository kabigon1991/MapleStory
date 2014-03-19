//
//  LoadAllRequest.m
//  NiftCarbon8
//
//  Created by Duc Nguyen on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HeinekenRegisterAppDelegate.h"
#import "LoadAllRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "Singleton.h"


enum {
   
    REGISTER = 0,
    SUBMITCODE = 1,
    SUBMITPHONE = 2,

};

@implementation LoadAllRequest
@synthesize delegate;


-(id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}





#pragma mark - REQUEST

/*
///////////////////////////////////////////////////////////
-(void) requestLoadGuestInfo
{
    Singleton *localData = [Singleton sharedVars];
    NSString *urlRequest = localData.urlSevices;
    
    ASIFormDataRequest *con = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlRequest]];
    [con setTag:REGISTER];
    [con setDelegate:self];
    [con setTimeOutSeconds:5];
    [con startAsynchronous];
}


///////////////////////////////////////////////////////////
-(void) requestGetGuestInfo
{
    Singleton *localData = [Singleton sharedVars];
    NSString *urlRequest = localData.urlSevices;
    
    ASIFormDataRequest *con = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlRequest]];
    [con setTag:GETGUESTINFO];
    [con setDelegate:self];
    [con setTimeOutSeconds:5];
    [con startAsynchronous];
}
*/
/*
///////////////////////////////////////////////////////////
-(void) requestLoadBackground
{
    Singleton *localData = [Singleton sharedVars];
    NSString *urlRequest = localData.urlSevicesBackground;
    
    ASIFormDataRequest *con = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlRequest]];
    [con setTag:BACKGROUND_REQUEST];
    [con setDelegate:self];
    [con setTimeOutSeconds:5];
    [con startAsynchronous];
}
 */
#pragma mark - FINISH REQUEST


///////////////////////////////////////////////////////////
//--Request failed
-(void) requestFailed:(ASIHTTPRequest *) request
{
    switch (request.tag) {
        
        case REGISTER:
            [[self delegate] didFaildRequestPostInfoSucessfull];
            break;
        
        case SUBMITCODE:
            [[self delegate] didFaildRequestPostCodeSucessfull];
            break;
        case SUBMITPHONE:
            [[self delegate] didFaildRequestInfoDuplicateSucessfull];
            break;


        default:
            break;
    }
}




///////////////////////////////////////////////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSDictionary *dic = nil;
    dic = [self parsejSonStringFromRequest:request];
    switch (request.tag) {
        
        case REGISTER:
            if (dic){
                [[self delegate] didRequestPostInfo:dic];
            }
            else
                [[self delegate] didFaildRequestPostInfoSucessfull];
            break;
    
        case SUBMITCODE:
            if (dic){
                [[self delegate] didRequestPostCode:dic];
            }
            else
                [[self delegate] didFaildRequestPostCodeSucessfull];
            break;
            
        case SUBMITPHONE:
            if (dic){
                [[self delegate] didRequestInfoDuplicate:dic];
            }
            else
                [[self delegate] didFaildRequestInfoDuplicateSucessfull];
            break;

            
               default:
            break;
    }
  }    


-(void) requestPostGuestInfo:(GuestInfo *) guestInfo andAvatar:(NSString *) path andName:(NSString *)imageName{
 //   NSLog(@" tesst :::  %@  ",path);
    Singleton *localData = [Singleton sharedVars];
    NSString *urlRequest = localData.urlSevices;
    

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlRequest]];
    
    [request addPostValue:guestInfo.fullName forKey:@"name"];
    [request addPostValue:guestInfo.phone forKey:@"phone"];
    [request addPostValue:guestInfo.identification forKey:@"identification"];
    [request addPostValue:guestInfo.address forKey:@"address"];
    [request addPostValue:guestInfo.gender forKey:@"gender"];
    [request addPostValue:guestInfo.birthday forKey:@"birthday"];
    [request addPostValue:guestInfo.email forKey:@"email"];
    [request addPostValue:guestInfo.facebookAccount forKey:@"facebook_account"];
    [request addPostValue:guestInfo.location forKey:@"location"];
//    [request addFile:path forKey:@"avatar"];
//     NSLog(@" tesst :::  %@  ",path);
    if(![path isEqualToString:@""])
    {
//        NSLog(@" AA ");
        [request setFile:path forKey:@"avatar"];
    }
    else
    {
        [request setData:NULL withFileName:@"" andContentType:@"image/jpeg" forKey:@"avatar"];
    }

   
    
    //[request setFile:path withFileName:imageName andContentType:@"image/jpg"
              //forKey:@"avatar"];
    
    [request setTag:REGISTER];
    [request setDelegate:self];
    [request setTimeOutSeconds:15]; 
    [request startAsynchronous];
}

-(void) requestPostCode:(NSString *) user_id andCode:(NSString *) code_validate{
    Singleton *localData = [Singleton sharedVars];
    NSString *urlRequest = localData.urlSevicesCode;

    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlRequest]];

    [request addPostValue:user_id forKey:@"user_id"];
    [request addPostValue:code_validate forKey:@"code_validate"];
//    [request addFile:path forKey:@"avatar"];
    
    [request setTag:SUBMITCODE];
    [request setDelegate:self];
    [request setTimeOutSeconds:15];
    [request startAsynchronous];
}

-(void) requestInfoDuplicate:(NSString *) infoDuplicate{
    Singleton *localData = [Singleton sharedVars];
    NSString *urlRequest = localData.urlSevicesInfoDuplicate;
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlRequest]];
//    NSLog(@"sduhgfjshgfhdu-------: %@", infoDuplicate);
    [request addPostValue:infoDuplicate forKey:@"phone"];
    //    [request addFile:path forKey:@"avatar"];
    
    [request setTag:SUBMITPHONE];
    [request setDelegate:self];
    [request setTimeOutSeconds:15];
    [request startAsynchronous];
}
///////////////////////////////////////////////////////////SUBMITCODE
-(NSDictionary *) parsejSonStringFromRequest:(ASIHTTPRequest *) request
{
    //Error can not submit to server
    NSError *error = [request error];
    if (error)
    {
#ifdef DEBUG
        NSLog(@"We have a error from response login");
#endif
        return nil;
    }
    
    //PARSE DATA
    NSString *responseString = [request responseString];
    NSDictionary *json = [responseString JSONValue];
//    NSLog(@"jSon: %@", responseString);
    
    if(!json){
#ifdef DEBUG
        NSLog(@"Can not parse response string from login request");
        return nil;
#endif
    }
    
    return json;
}

    
                       
///////////////////////////////////////////////////////////                       
-(void) dealloc
{
        [managedObjectContext release];
        [super dealloc];
}


@end
