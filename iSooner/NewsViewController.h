//
//  NewsViewController.h
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SeriesObject;

@interface NewsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIImageView *banner;
    UITableView *tableView;
    NSMutableArray* newsDataObjects;
    SeriesObject *seriesObject;
}

@property (strong, nonatomic) IBOutlet UIImageView *banner;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* newsDataObjects;
@property (strong, nonatomic) SeriesObject *seriesObject;


- (void) addDataObjects:(NSArray*)dataObjects;
- (void) addSeriesObjects:(NSArray*)seriesObjects;
- (id) initWithSeriesObject:(SeriesObject*)sobject;
-(void) prepareForPushWithSeriesObject:(SeriesObject *)_seriesObject;

@end




