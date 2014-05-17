//
//  SOAPServices.m
//  Services
//
//  Created by Madusha Perera on 3/7/14.
//  Copyright (c) 2014 Madusha Perera. All rights reserved.
//

#import "SOAPServices.h"
#import "SOAPServiceDelegate.h"

@implementation SOAPServices
{
    NSString* soapMessage;
    NSMutableData*  webData;
    NSString* curDescription;
    BOOL isResult;
    NSString* _elementName;
    
}

-(void)requestInSOAPinitWithDelegate:(id<SOAPServiceDelegate>)soapDelegate ofUrl:(NSString*)urlString havingSOAPMessage:(NSString *)soapMsg forHTTPMethod:(NSString *)httpMethod forElement:(NSString *)element withRequestHeaders:(NSDictionary*) requestHeaders{

    self.soap_delegate = soapDelegate;
    soapMessage = soapMsg;
    _elementName = element;
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];

    // set the request headers
    for(id key in requestHeaders){
        [theRequest addValue: requestHeaders[key] forHTTPHeaderField:key];
    }
    
    if(httpMethod == nil){
        [theRequest setHTTPMethod:@"POST"];
    }else{
        [theRequest setHTTPMethod:httpMethod];
    }
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(theConnection)
    {
        webData = [NSMutableData data] ;
        NSLog(@"The connection is OK");
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *respons = (NSHTTPURLResponse*)response;
    NSLog(@"response code: %d",respons.statusCode);
    
    webData = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:webData];
    xmlParser.delegate = self;
    [xmlParser parse];
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:
(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"parsed elements name : %@", elementName);
    
    if ([elementName isEqualToString:_elementName])
        isResult = YES;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (isResult)
        NSLog(@"value is %@",string);
    [self.soap_delegate getValue: string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:_elementName])
        isResult = NO;
}


@end
