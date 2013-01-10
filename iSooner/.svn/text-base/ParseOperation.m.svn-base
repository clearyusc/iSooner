/*
     File: ParseOperation.m
 Abstract: The NSOperation class used to perform the XML parsing of job object data.
  Version: 2.3
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "ParseOperation.h"
#import "DataObject.h"
#import "SeriesObject.h"
#import "Constants.h"


@interface ParseOperation () <NSXMLParserDelegate>
    @property (nonatomic, retain) DataObject *currentDataObject;
    @property (nonatomic, retain) SeriesObject *currentSeriesObject;
    @property (nonatomic, retain) NSMutableArray *currentSeriesArray;
    @property (nonatomic, retain) NSMutableString *currentParsedCharacterData;
    @property (nonatomic, retain) NSMutableArray *currentSectionArray;

@end

@implementation ParseOperation

@synthesize currentDataObject, currentParsedCharacterData, currentSeriesArray, xmlData, currentSeriesObject, currentSection, currentSectionArray, appDelegate;

- (id)initWithData:(NSData *)parseData
{
    if (self = [super init]) {    
        xmlData = [parseData copy];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    }
    return self;
}

- (void)addSectionToList:(NSDictionary *)sectionDictionary {
    assert([NSThread isMainThread]);
    
    // We need a way to be able to tell the app delegate which section we are in
    
   /* NSMutableDictionary *userInfoDictionary = [[NSMutableDictionary alloc] init];
    [userInfoDictionary setObject:@"news" forKey:@"section"]; // for now write it to news
    [userInfoDictionary setObject:seriesObjects forKey:kSeriesObjectsResultsKey];
*/
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddSeriesObjectsNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:sectionDictionary
                                                                                           forKey:kSectionDictionaryKey]]; 
    
}

     
// the main function for this NSOperation, to start the parsing
- (void)main {
    self.currentSeriesArray = [[NSMutableArray alloc] init];
    self.currentSectionArray = [[NSMutableArray alloc] init];
    self.currentParsedCharacterData = [NSMutableString string];
    self.currentSeriesObject = [[SeriesObject alloc] init];  

    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is
    // not desirable because it gives less control over the network, particularly in responding to
    // connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.xmlData];
    [parser setDelegate:self];
    [parser parse];
    
    // depending on the total number of dataobjects parsed, the last batch might not have been a
    // "full" batch, and thus not been part of the regular batch transfer. So, we check the count of
    // the array and, if necessary, send it to the main thread.
    //
    /*
    if ([self.currentSeriesArray count] > 0) {
        [self performSelectorOnMainThread:@selector(addSectionToList:)
                               withObject:self.currentSeriesArray
                            waitUntilDone:NO];
    }*/
    
    self.currentSeriesArray = nil;
    self.currentDataObject = nil;
    self.currentParsedCharacterData = nil;
}



#pragma mark -
#pragma mark NSXMLParser delegate methods

// ---------------------------------- START OF ELEMENT ---------------------------------
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                        namespaceURI:(NSString *)namespaceURI
                                       qualifiedName:(NSString *)qName
                                          attributes:(NSDictionary *)attributeDict 
{

    if ([Constants validSection:elementName])
    {
        // NEW SECTION
        
//        self.appDelegate.currentSection = [NSString stringWithString:elementName]; // update the appdelegate's section name so that it knows where to put the items
        self.currentSection = [NSString stringWithString:elementName]; // Update the section string
        
    }
    else if ([elementName isEqualToString:kSeriesElementName])
    {
        // NEW SERIES
        
        self.currentSeriesObject = [[SeriesObject alloc] init];  // Now create a new SeriesObject to represent this series
        [self.currentSectionArray addObject:self.currentSeriesObject]; // Add the current series object to the section array.  
        self.currentSeriesArray = [[NSMutableArray alloc] init]; // And make a new array to hold the DataObjects in this SERIES
        
    }
    else if ([elementName isEqualToString:kEntryElementName]) 
    {
        // NEW ENTRY (DATA OBJECT)
        
        self.currentDataObject = [[DataObject alloc] init]; // Create a new DataObject to hold the data of this entry
        
    } 
    else if ([Constants shouldAccumulateParsedCharacterData:elementName])  
    {
        // DATA
        
        accumulatingParsedCharacterData = YES; // The contents are collected in parser:foundCharacters:
        [currentParsedCharacterData setString:@""]; // The mutable string needs to be reset to empty.
        
    }
}


// --------------------------------------- END OF ELEMENT --------------------------------------
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
                                      namespaceURI:(NSString *)namespaceURI
                                     qualifiedName:(NSString *)qName 
{     
    
    if ([Constants validSection:elementName])
    {
        // END OF A SECTION 
        
        // We need to make a dictionary so that we can store both the SECTION NAME and the SECTION ARRAY 
        NSMutableDictionary *sectionDictionary = [[NSMutableDictionary alloc] init];
        [sectionDictionary setObject:self.currentSectionArray forKey:@"array"];
        [sectionDictionary setObject:self.currentSection forKey:@"name"];

        // So go ahead and push the array of series out to the view controllers
        [self performSelectorOnMainThread:@selector(addSectionToList:)
                               withObject:sectionDictionary
                            waitUntilDone:NO];
        
        self.currentSectionArray = [[NSMutableArray alloc] init]; // Create a new array to hold the SeriesObjects in this section

    }
    else if ([elementName isEqualToString:kSeriesElementName])
    {
        // END OF A SERIES
        
        [self.currentSeriesObject setChildObjects:[NSMutableArray arrayWithArray:self.currentSeriesArray]];
        
    }
    else if ([elementName isEqualToString:kEntryElementName]) 
    {
        // END OF AN ENTRY
        
        [self.currentSeriesArray addObject:self.currentDataObject];
        parsedDataObjectsCounter++; 
        
    } 
    // 
    // END OF DATA ELEMENTS
    //   A more detailed approach, as it is element-specific.
    // 
    else if ([elementName isEqualToString:kSeriesTitleElementName])
    {
        NSLog(@"%@ = %@",kSeriesTitleElementName,self.currentParsedCharacterData);
        [self.currentSeriesObject setTitle:[NSString stringWithString:self.currentParsedCharacterData]];
    }
    else if ([elementName isEqualToString:kSeriesImageElementName])
    {       
        NSLog(@"%@ = %@",kSeriesImageElementName,self.currentParsedCharacterData);
        [self.currentSeriesObject setImageURLString:[NSString stringWithString:self.currentParsedCharacterData]];
    }
    else if ([elementName isEqualToString:kTitleElementName]) 
    {
        NSLog(@"%@ = %@",kTitleElementName,self.currentParsedCharacterData);
        [self.currentDataObject setTitle:[NSString stringWithString:self.currentParsedCharacterData]];
    } 
    else if ([elementName isEqualToString:kLinkElementName])
    {
        NSLog(@"%@ = %@",kLinkElementName,self.currentParsedCharacterData);
        [self.currentDataObject setLink:[NSURL URLWithString:self.currentParsedCharacterData]];
    }
    else if ([elementName isEqualToString:kDateElementName])
    {
        // Take the string and convert it into a date 
        NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [_dateFormatter dateFromString:self.currentParsedCharacterData];
        [self.currentDataObject setDate:dateFromString];
        
        
        // Now pull out the month abbreviation 
        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
        [monthFormatter setDateFormat:@"MMM"]; //month abbreviations
        NSString *monthStr = [monthFormatter stringFromDate:self.currentDataObject.date];
        [self.currentDataObject setMonth:[NSString stringWithString:monthStr]];
        
        
        // And pull out the numbers for the day of the month
        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
        [dayFormatter setDateFormat:@"dd"]; 
        NSString *dayStr = [dayFormatter stringFromDate:self.currentDataObject.date];
        [self.currentDataObject setDay:[NSString stringWithString:dayStr]];
        
        
    }
    else if ([elementName isEqualToString:kScriptureElementName])
    {
        NSLog(@"%@ = %@",kScriptureElementName,self.currentParsedCharacterData);

        NSString *scripStr = [[NSString alloc] initWithString:self.currentParsedCharacterData];
        [self.currentDataObject setScripture:[NSString stringWithString:scripStr]];
        
    }
    else if ([elementName isEqualToString:kAuthorElementName])
    {
        NSLog(@"%@ = %@",kAuthorElementName,self.currentParsedCharacterData);
        
        [self.currentDataObject setAuthor:[NSString stringWithString:self.currentParsedCharacterData]];
        
    }
    else if ([elementName isEqualToString:kUpdatedElementName]) 
    {
        /*
        if (self.currentDataObject != nil) {
            self.currentDataObject.date = [dateFormatter dateFromString:self.currentParsedCharacterData];
        }
        else {
            // kUpdatedElementName can be found outside an entry element (i.e. in the XML header)
            // so don't process it here.
        }
         */
    } 
    else if ([elementName isEqualToString:kGeoRSSPointElementName]) 
    {
        /*
        // The georss:point element contains the latitude and longitude of the epicenter.
        // 18.6477 -66.7452
        //
        NSScanner *scanner = [NSScanner scannerWithString:self.currentParsedCharacterData];
        double latitude, longitude;
        if ([scanner scanDouble:&latitude]) {
            if ([scanner scanDouble:&longitude]) {
                self.currentDataObject.latitude = latitude;
                self.currentDataObject.longitude = longitude;
            }
        }
         */
    }
    
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    accumulatingParsedCharacterData = NO;
}

// This method is called by the parser when it find parsed character data ("PCDATA") in an element.
// The parser is not guaranteed to deliver all of the parsed character data for an element in a single
// invocation, so it is necessary to accumulate character data until the end of the element is reached.
//
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (accumulatingParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        //
        [self.currentParsedCharacterData appendString:string];
    }
}

// an error occurred while parsing the dataobject data,
// post the error as an NSNotification to our app delegate.
// 
- (void)handleDataObjectsError:(NSError *)parseError {
    [[NSNotificationCenter defaultCenter] postNotificationName:kDataObjectsErrorNotif
                                                    object:self
                                                  userInfo:[NSDictionary dictionaryWithObject:parseError
                                                                                       forKey:kDataObjectsMsgErrorKey]];
}

// an error occurred while parsing the DataObject data,
// pass the error to the main thread for handling.
// (note: don't report an error if we aborted the parse due to a max limit of dataobjects)
//
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if ([parseError code] != NSXMLParserDelegateAbortedParseError && !didAbortParsing)
    {
        [self performSelectorOnMainThread:@selector(handleDataObjectsError:)
                               withObject:parseError
                            waitUntilDone:NO];
    }
}

@end





