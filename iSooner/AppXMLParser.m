//
//  AppXMLParser.m
//  iSooner
//
//  Created by Ryan Cleary on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppXMLParser.h"

@implementation AppXMLParser

@synthesize receivedData;

- (void) begin
{
    // Request data from URL
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithString:@"http://www.bonifacedesigns.com/tuts/xmltest.xml"]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Start loading data
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection)
    {
        // Create the data object to hold the downloaded data
        receivedData = [[NSMutableData alloc] init];
    }
    else
    {
        NSLog(@"Error, the xml connection failed.");
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}


@end







