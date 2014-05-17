//
//  SOAPServices.h
//  Services
//
//  Created by Madusha Perera on 3/7/14.
//  Copyright (c) 2014 Madusha Perera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOAPServiceDelegate.h"


@interface SOAPServices : NSObject<NSURLConnectionDelegate,NSXMLParserDelegate>

@property(nonatomic,assign) id<SOAPServiceDelegate> soap_delegate;

//if http method is nil default is POST
-(void)requestInSOAPinitWithDelegate:(id<SOAPServiceDelegate>)soapDelegate ofUrl:(NSString*)urlString havingSOAPMessage:(NSString*) soapMsg forHTTPMethod: (NSString*)httpMethod forElement:(NSString*) element withRequestHeaders:(NSDictionary*) requestHeaders;

@end
