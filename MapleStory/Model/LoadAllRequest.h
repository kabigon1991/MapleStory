//
//  LoadAllRequest.h
//  NiftCarbon8
//
//  Created by Duc Nguyen on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "GuestInfo.h"

//--Delegate call back when requesr didload
@protocol BizzonRequestDelagate <NSObject>

@optional


-(void) didRequestPostInfo:(NSDictionary *) dictionary;
-(void) didFaildRequestPostInfoSucessfull;


-(void) didRequestPostCode:(NSDictionary *) dictionary;
-(void) didFaildRequestPostCodeSucessfull;

-(void) didRequestInfoDuplicate:(NSDictionary *) dictionary;
-(void) didFaildRequestInfoDuplicateSucessfull;

@end



@interface LoadAllRequest : NSObject
{
    id<BizzonRequestDelagate> delegate;
    NSManagedObjectContext *managedObjectContext;
    
}
@property (nonatomic, assign) id delegate;



///////////////////////////////////////////////////////////
//--Parse jSon
-(NSDictionary *) parsejSonStringFromRequest:(ASIHTTPRequest *) request;


//-(void) requestGetGuestInfo;
//-(void) requestLoadAlbum;
//-(void) requestLoadBackground;

-(void) requestPostGuestInfo:(GuestInfo *) guestInfo andAvatar:(NSString *) path andName:(NSString *)imageName;
-(void) requestPostCode:(NSString *) user_id andCode:(NSString *) code_validate;
-(void) requestInfoDuplicate:(NSString *) infoDuplicate;
@end
