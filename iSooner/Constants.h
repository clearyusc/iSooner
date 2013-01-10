//
//  Constants.h
//  iSooner
//
//  Created by Ryan Cleary on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CELL_HEIGHT_IPAD            80
#define CELL_HEIGHT_IPHONE          60
#define SERIES_THUMBNAIL_IPAD       78
#define SERIES_THUMBNAIL_IPHONE     58
#define TABLEVIEW_Y_LOCATION_IPAD   320
#define BANNER_HEIGHT_IPAD          320
#define TABLEVIEW_Y_LOCATION_IPHONE 120
#define BANNER_HEIGHT_IPHONE         120



#define kAddDataObjectsNotif            @"AddDataObjectsNotif"          // NSNotification name for sending dataobject data back to the app delegate
#define kAddSeriesObjectsNotif          @"AddSeriesObjectsNotif"
#define kSeriesObjectsResultsKey        @"SeriesObjectsResultsKey" 
#define kDataObjectsResultsKey          @"DataObjectsResultsKey"        // NSNotification userInfo key for obtaining the dataobject data
#define kDataObjectsErrorNotif          @"DataObjectsErrorNotif"        // NSNotification name for reporting errors
#define kDataObjectsMsgErrorKey         @"DataObjectsMsgErrorKey"       // NSNotification userInfo key for obtaining the error message
#define kSectionDictionaryKey           @"AddSectionDictionaryKey"

// Reduce potential parsing errors by using string constants declared in a single place.
#define kUpdatedElementName         @"updated"
#define kGeoRSSPointElementName     @"georss:point"

// For parsing Entries (sermons, teachings, notes, etc)
#define kEntryElementName           @"entry"
#define kTitleElementName           @"title"
#define kAuthorElementName          @"author"
#define kDescriptionElementName     @"description"
#define kScriptureElementName       @"scripture"
#define kDateElementName            @"date"
#define kLinkElementName            @"link"

// For parsing Series
#define kSeriesElementName          @"series"
#define kSeriesTitleElementName     @"seriesTitle"
#define kSeriesImageElementName     @"seriesImg"

// Larger element names
#define kNewsElementName            @"news"
#define kFPCElementName             @"fpc"
#define kResourcesElementName       @"resources"

// FPC Sub-category element names
#define kYouthElementName           @"youth"
#define kCollegeElementName         @"college"
#define kYoungAdultElementName      @"youngAdult"
#define kAllChurchElementName       @"allChurch"

// Resources Sub-category element names
#define kSermonsElementName         @"sermons"
#define kDevotionalsElementName     @"devotionals"
#define kApologeticsElementName     @"apologetics"
#define kOtherElementName           @"other"



// ----- Currently unused ----
// When a DataObject object has been fully constructed, it must be passed to the main thread and
// the table view in RootViewController must be reloaded to display it. It is not efficient to do
// this for every DataObject object - the overhead in communicating between the threads and reloading
// the table exceed the benefit to the user. Instead, we pass the objects in batches, sized by the
// constant below. In your application, the optimal batch size will vary 
// depending on the amount of data in the object and other factors, as appropriate.
//

#define kSizeOfParseBatch           10
// ---------------------------

@interface Constants:NSObject 

+(BOOL)validSection:(NSString*)name;
+(BOOL)shouldAccumulateParsedCharacterData:(NSString*)name;

@end













