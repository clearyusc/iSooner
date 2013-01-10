//
//  DataObject.h
//  iSooner
//
//  Created by Ryan Cleary on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppObject.h"

@interface DataObject : AppObject
{
    NSString *scripture;
    NSString *author;
    NSString *month;
    NSString *description;
    NSString *day;
    NSURL *link;
    // seriesImg - link or uiimage?
}

@property (strong, nonatomic) NSString *scripture;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSURL *link;

-(id)initWithDataObject:(DataObject*)d;


@end



