//
//  AppDelegate.h
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsViewController, FPCViewController, ResourcesViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
@private
    // for downloading the xml data
    NSURLConnection *xmlConnection;
    NSMutableData *xmlData;
    
    NSOperationQueue *parseQueue;
    
    NewsViewController *newsViewController;
    FPCViewController *fpcViewController;
    ResourcesViewController *resourceViewController;
    
    NSString *currentSection;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) NSURLConnection *xmlConnection;
@property (strong, nonatomic) NSMutableData *xmlData;
@property (strong, nonatomic) NSOperationQueue *parseQueue;

@property (strong, nonatomic) NewsViewController *newsViewController;
@property (strong, nonatomic) FPCViewController *fpcViewController;
@property (strong, nonatomic) ResourcesViewController *resourceViewController;

@property (strong, nonatomic) NSString *currentSection;

@end
