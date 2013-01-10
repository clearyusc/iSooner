//
//  ResourcesViewController.h
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourcesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
    NSMutableArray *resourcesObjects;
    IBOutlet UISegmentedControl *filterControl;
    NSMutableDictionary *segmentDictionary;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterControl;
@property (strong, nonatomic) NSMutableArray *resourcesObjects;
@property (strong, nonatomic) NSMutableDictionary *segmentDictionary;

- (void) addSeriesObjects:(NSArray*)seriesObjects intoSegment:(NSString *)segment;

@end




