//
//  SecondViewController.h
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPCViewController: UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
    IBOutlet UISegmentedControl *filterControl;
    NSMutableArray *fpcObjects;
    NSMutableDictionary *segmentDictionary;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterControl;
@property (strong, nonatomic) NSMutableArray *fpcObjects;
@property (strong, nonatomic) NSMutableDictionary *segmentDictionary;

- (void) addSeriesObjects:(NSArray*)seriesObjects intoSegment:(NSString *)segment;


@end



