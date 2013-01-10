//
//  AppDelegate.m
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "NewsViewController.h"
#import "FPCViewController.h"
#import "ResourcesViewController.h"
#import "ParseOperation.h"
#import "Constants.h"
#import "SeriesObject.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize xmlConnection, xmlData, parseQueue;
@synthesize newsViewController, fpcViewController, resourceViewController;
@synthesize currentSection;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsViewController_iPhone" bundle:nil];
        fpcViewController = [[FPCViewController alloc] initWithNibName:@"FPCViewController_iPhone" bundle:nil];
        resourceViewController = [[ResourcesViewController alloc] initWithNibName:@"ResourcesViewController_iPhone" bundle:nil];
    } else {
        newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsViewController_iPad" bundle:nil];
        fpcViewController = [[FPCViewController alloc] initWithNibName:@"FPCViewController_iPad" bundle:nil];
        resourceViewController = [[ResourcesViewController alloc] initWithNibName:@"ResourcesViewController_iPad" bundle:nil];
    }
    
    // Set up the Navigation Controllers
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:newsViewController];   
    navController1.navigationBar.tintColor = [UIColor blackColor];
    
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:fpcViewController];   
    navController2.navigationBar.tintColor = [UIColor blackColor];

    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:resourceViewController];   
    navController3.navigationBar.tintColor = [UIColor blackColor];

    
    // Set up the Tab Bar Controller
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
        
    
    // XML Parsing
    //static NSString *feedURLString = @"http://earthquake.usgs.gov/eqcenter/catalogs/7day-M2.5.xml";
    static NSString *feedURLString = @"ftp://sooner:Nels2962@sooner.org/public_html/fpc/iSooner_XML_1.0.xml";
    
    NSURLRequest *urlRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    self.xmlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    
    // Start the status bar network activity indicator. We'll turn it off when the connection
    // finishes or experiences an error.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    parseQueue = [NSOperationQueue new];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addDataObjects:)
                                                 name:kAddDataObjectsNotif
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addSectionToList:)
                                                 name:kAddSeriesObjectsNotif
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataObjectsError:)
                                                 name:kDataObjectsErrorNotif
                                               object:nil];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/



#pragma mark -
#pragma mark NSURLConnection delegate methods

// The following are delegate methods for NSURLConnection. Similar to callback functions, this is
// how the connection object, which is working in the background, can asynchronously communicate back
// to its delegate on the thread from which it was started - in this case, the main thread.
//
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // check for HTTP status code for proxy authentication failures
    // anything in the 200 to 299 range is considered successful,
    // also make sure the MIMEType is correct:
    //
    
    self.xmlData = [NSMutableData data]; //this is how we bypass the restrictions on the ftp

    
    /*
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"application/atom+xml"]) {
        self.xmlData = [NSMutableData data];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        [self handleError:error];
    }
     */
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [xmlData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo =
        [NSDictionary dictionaryWithObject:
         NSLocalizedString(@"No Connection Error",
                           @"Error message displayed when not connected to the Internet.")
                                    forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
    } else {
        // otherwise handle the error generically
        [self handleError:error];
    }
    self.xmlConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.xmlConnection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    // Spawn an NSOperation to parse the data so that the UI is not blocked while the
    // application parses the XML data.
    //
    // IMPORTANT! - Don't access or affect UIKit objects on secondary threads.
    //
    ParseOperation *parseOperation = [[ParseOperation alloc] initWithData:self.xmlData];
    [parseOperation setAppDelegate:self];
    [self.parseQueue addOperation:parseOperation];
    
    // data will be retained by the NSOperation until it has finished executing,
    // so we no longer need a reference to it in the main thread.
    self.xmlData = nil;
}

// Handle errors in the download by showing an alert to the user. This is a very
// simple way of handling the error, partly because this application does not have any offline
// functionality for the user. Most real applications should handle the error in a less obtrusive
// way and provide offline functionality to the user.
//
- (void)handleError:(NSError *)error {
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:
     NSLocalizedString(@"Error Title",
                       @"Title for alert displayed when download or parse error occurs.")
                               message:errorMessage
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alertView show];
}

// Our NSNotification callback from the running NSOperation to add the dataobjects
//
- (void)addDataObjects:(NSNotification *)notif {
    assert([NSThread isMainThread]);
    
    [self addDataObjectsToList:[[notif userInfo] valueForKey:kDataObjectsResultsKey]];
}

// Our NSNotification callback from the running NSOperation to add the section
//
- (void)addSectionToList:(NSNotification *)notif
{
    assert([NSThread isMainThread]);
    
    //NSString *section = ((ParseOperation*)[self.parseQueue.operations lastObject]).currentSection;
    NSString *section = [[[notif userInfo] valueForKey:kSectionDictionaryKey] objectForKey:@"name"];

    
    /*if ([[[notif userInfo] valueForKey:@"section"] isEqualToString:@"news"])
    {
        [self addSectiontoNewsList:[[notif userInfo] valueForKey:kSeriesObjectsResultsKey]];
    }
    else if ([[[notif userInfo] valueForKey:@"section"] isEqualToString:@"FPC"])
    {
        [self addSectionToFPCList:[[notif userInfo] valueForKey:kSeriesObjectsResultsKey]];
    }*/
    
    if ([section isEqualToString:kNewsElementName])
    {
        // NEWS
        NSArray *arr = [[[notif userInfo] valueForKey:kSectionDictionaryKey] objectForKey:@"array"];
        [newsViewController addSeriesObjects:arr];
    }
    else if ([section isEqualToString:kFPCElementName] || [section isEqualToString:kYouthElementName] 
             || [section isEqualToString:kCollegeElementName] || [section isEqualToString:kYoungAdultElementName]
             || [section isEqualToString:kAllChurchElementName])
    {
        // FPC
       /* NSArray *arr = [[notif userInfo] valueForKey:kSectionDictionaryKey];
        
        for (int i = 0; i < arr.count; i++)
        {
            NSLog(@"____ %@",((SeriesObject*)[arr objectAtIndex:i]).title);
        } */
        
        NSArray *arr = [[[notif userInfo] valueForKey:kSectionDictionaryKey] objectForKey:@"array"];
        [fpcViewController addSeriesObjects:arr intoSegment:section];
    }
    else if ([section isEqualToString:kResourcesElementName] || [section isEqualToString:kSermonsElementName] 
             || [section isEqualToString:kDevotionalsElementName] || [section isEqualToString:kApologeticsElementName]
             || [section isEqualToString:kOtherElementName])
    {
        // RESOURCES 
        NSArray *arr = [[[notif userInfo] valueForKey:kSectionDictionaryKey] objectForKey:@"array"];
        [resourceViewController addSeriesObjects:arr intoSegment:section];
    }
}

// Our NSNotification callback from the running NSOperation when a parsing error has occurred
//
- (void)dataObjectsError:(NSNotification *)notif {
    assert([NSThread isMainThread]);
    
    [self handleError:[[notif userInfo] valueForKey:kDataObjectsMsgErrorKey]];
}

// The NSOperation "ParseOperation" calls addDataObjects: via NSNotification, on the main thread
// which in turn calls this method, with batches of parsed objects.
// The batch size is set via the kSizeOfEarthquakeBatch constant.
//

- (void)addDataObjectsToList:(NSArray *)dataObjects {
    
    // insert the earthquakes into our rootViewController's data source (for KVO purposes)
    //[self.rootViewController insertEarthquakes:earthquakes];
    [newsViewController addDataObjects:dataObjects];
    //    NSLog(@"DataObjects: %@", dataObjects);
}





@end






