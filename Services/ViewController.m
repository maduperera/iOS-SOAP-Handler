//
//  ViewController.m
//  Services
//
//  Created by Madusha Perera on 3/7/14.
//  Copyright (c) 2014 Madusha Perera. All rights reserved.
//

#import "ViewController.h"
#import "SOAPServiceDelegate.h"
#import "SOAPServices.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // sample code to test the SOAPService : used the w3schools sample SOAP service to test
    SOAPServices* soapRequest = [[SOAPServices alloc]init];

    NSString* soapmsg = @"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><CelsiusToFahrenheit xmlns='http://www.w3schools.com/webservices/'><Celsius>30</Celsius></CelsiusToFahrenheit></soap:Body></soap:Envelope>";
    
    NSString* url = @"http://www.w3schools.com/webservices/tempconvert.asmx";
    NSString* soapAction = @"http://www.w3schools.com/webservices/CelsiusToFahrenheit";
    // set the request headers
    NSDictionary* requestHeaders = @{@"Content-Type":@"text/xml; charset=utf-8",@"SOAPAction":soapAction,@"Content-Length":[NSString stringWithFormat:@"%d", [soapmsg length]]};
    
    [soapRequest requestInSOAPinitWithDelegate:self ofUrl:url havingSOAPMessage:soapmsg forHTTPMethod:@"POST" forElement:@"CelsiusToFahrenheitResult" withRequestHeaders:requestHeaders];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// the delegates method that being realized
-(void)getValue:(NSString*)value{
    
    NSLog(@"the value got in delegate : %@", value);
}

@end
