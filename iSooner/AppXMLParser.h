//
//  AppXMLParser.h
//  iSooner
//
//  Created by Ryan Cleary on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppXMLParser : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *receivedData;
}

@property (nonatomic, strong) NSMutableData *receivedData;



@end





