//
//  AppObject.h
//  iSooner
//
//  Created by Ryan Cleary on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppObject : NSObject
{
    NSString *title;
    NSDate *date;
    AppObject *parentObject;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) AppObject *parentObject;


@end
