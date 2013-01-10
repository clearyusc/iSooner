//
//  Constants.m
//  iSooner
//
//  Created by Ryan Cleary on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"

@implementation Constants

/**
 * Returns true if the name parameter is the name of a section. 
 */
+(BOOL)validSection:(NSString*)name
{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:kNewsElementName];
  //  [arr addObject:kFPCElementName];
  //  [arr addObject:kResourcesElementName];
    
    [arr addObject:kYouthElementName];
    [arr addObject:kCollegeElementName];
    [arr addObject:kYoungAdultElementName];
    [arr addObject:kAllChurchElementName];
    
    [arr addObject:kSermonsElementName];
    [arr addObject:kDevotionalsElementName];
    [arr addObject:kApologeticsElementName];
    [arr addObject:kOtherElementName];
    
    
    for (int i = 0; i < arr.count; i++)
    {
        if ([name isEqualToString:[arr objectAtIndex:i]])
        {
            return true;
        }
    }
    
    return false;
}

/**
 * Returns true if the XMLParser should accumulate parsed character data given the element name.  
 */
+(BOOL)shouldAccumulateParsedCharacterData:(NSString*)name
{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    // SeriesObject
    [arr addObject:kSeriesTitleElementName];
    [arr addObject:kSeriesImageElementName];
    
    // DataObject
    [arr addObject:kTitleElementName];
    [arr addObject:kAuthorElementName];
    [arr addObject:kDescriptionElementName];
    [arr addObject:kScriptureElementName];
    [arr addObject:kDateElementName];
    [arr addObject:kLinkElementName];
    
    
    
    for (int i = 0; i < arr.count; i++)
    {
        if ([name isEqualToString:[arr objectAtIndex:i]])
        {
            return true;
        }
    }
    
    return false;
}


@end




