//
//  DataObject.m
//  iSooner
//
//  Created by Ryan Cleary on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataObject.h"

@implementation DataObject

@synthesize scripture, author, month, description, link, day;

-(id)initWithDataObject:(DataObject*)d
{
    self = [super init];
    if (self) 
    {
        self.title = d.title;
        self.date = d.date;
        self.parentObject = d.parentObject;
        self.scripture = d.scripture;
        self.author = d.author;
        self.month = d.month;
        self.day = d.day;
        self.description = d.description;
        self.link = d.link;
        
    }

    return self;
}


@end



