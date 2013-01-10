//
//  SecondViewController.m
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FPCViewController.h"
#import "Constants.h"
#import "CustomCell.h"
#import "SeriesObject.h"
#import "DataObject.h"
#import "MyMovieViewController.h"
#import "NewsViewController.h"

@interface FPCViewController ()

@end

@implementation FPCViewController


@synthesize tableView, filterControl, fpcObjects, segmentDictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = @"FPC";
        self.tabBarItem.image = [UIImage imageNamed:@"house"];
        
        // Initialized the Data Arrays
        fpcObjects = [[NSMutableArray alloc] init];
        segmentDictionary = [[NSMutableDictionary alloc] init];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kYouthElementName];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kCollegeElementName];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kYoungAdultElementName];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kAllChurchElementName];
        
        // Set up the table view:
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:tableView];
        
        // Set up the filter control tabs:
        [filterControl addTarget:self
                             action:@selector(filterControlChanged:)
                   forControlEvents:UIControlEventValueChanged];

    }
    
    return self;
}

- (void) addSeriesObjects:(NSArray*)seriesObjects intoSegment:(NSString *)segment
{
    
    if ([segment isEqualToString:kYouthElementName])
    {
        [[self.segmentDictionary objectForKey:kYouthElementName] addObjectsFromArray:seriesObjects];
    }
    else if ([segment isEqualToString:kCollegeElementName])
    {
        [[self.segmentDictionary objectForKey:kCollegeElementName] addObjectsFromArray:seriesObjects];
    }
    else if ([segment isEqualToString:kYoungAdultElementName])
    {
        [[self.segmentDictionary objectForKey:kYoungAdultElementName] addObjectsFromArray:seriesObjects];
    }
    else if ([segment isEqualToString:kAllChurchElementName])
    {
        [[self.segmentDictionary objectForKey:kAllChurchElementName] addObjectsFromArray:seriesObjects];
    }
    
    // Make sure you are showing the correct data for the segment you are currently in
    [self updateSegments];
    [tableView reloadData];
}

-(void)updateSegments
{
    switch (filterControl.selectedSegmentIndex) {
        case 0: // Youth
            fpcObjects = [self.segmentDictionary objectForKey:kYouthElementName];
            [tableView reloadData];
            break;
        case 1: // College
            fpcObjects = [self.segmentDictionary objectForKey:kCollegeElementName];
            [tableView reloadData];
            break;
        case 2: // Young Adult
            fpcObjects = [self.segmentDictionary objectForKey:kYoungAdultElementName];
            [tableView reloadData];
            break;
        case 3: // All Church
            fpcObjects = [self.segmentDictionary objectForKey:kAllChurchElementName];
            [tableView reloadData];
            break;
            
        default:
            break;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [self setFilterControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     } else {
     return YES;
     }*/
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)filterControlChanged:(id)sender
{
    [self updateSegments];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return fpcObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
    {
        return CELL_HEIGHT_IPAD;
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return CELL_HEIGHT_IPHONE;
    }
    
    return 40; //error 
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([((AppObject*)[fpcObjects objectAtIndex:indexPath.row]) isKindOfClass:[DataObject class]])
    {
        //##########################
        //# CUSTOM CELL FORMATTING #
        //##########################
        static NSString *customCellIdentifier = @"CustomCell";
        
        CustomCell *customCell = (CustomCell *)[_tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
        
        
        if (customCell == nil) 
        {
            // DATA OBJECT CELL
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell_iPad" owner:self options:nil];
                customCell = [nib objectAtIndex:0];
            }
            else
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell_iPhone" owner:self options:nil];
                customCell = [nib objectAtIndex:0];
            }
            customCell.titleLabel.text = ((AppObject*)[fpcObjects objectAtIndex:indexPath.row]).title;
            customCell.scriptureLabel.text = ((DataObject*)[fpcObjects objectAtIndex:indexPath.row]).scripture;
            customCell.authorLabel.text = ((DataObject*)[fpcObjects objectAtIndex:indexPath.row]).author;
            customCell.monthLabel.text = ((DataObject*)[fpcObjects objectAtIndex:indexPath.row]).month;
            customCell.dayLabel.text = ((DataObject*)[fpcObjects objectAtIndex:indexPath.row]).day;

        } 

        return customCell;

    }
    else //if ([[fpcObjects objectAtIndex:indexPath.row] isKindOfClass:[SeriesObject class]])
    {
        //##########################
        //# SERIES CELL FORMATTING #
        //##########################
        static NSString *cellIdentifier = @"cellIdentifier";
        
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        
        if (cell == nil) 
        {
            // SERIES OBJECT CELL
            cell = [[UITableViewCell alloc] init];
            cell.textLabel.text = ((SeriesObject*)[fpcObjects objectAtIndex:indexPath.row]).title;
            NSURL *url = [NSURL URLWithString:((SeriesObject*)[fpcObjects objectAtIndex:indexPath.row]).imageURLString];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]]; 
            cell.imageView.image = img;
        }
        
        return cell;
    }
    
    
    return nil;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Create and push another view controller.
    if ([[fpcObjects objectAtIndex:indexPath.row] isKindOfClass:[DataObject class]])
    {
        NSURL *dataURL = ((DataObject*)[fpcObjects objectAtIndex:indexPath.row]).link;
		if (dataURL)
		{
			if ([dataURL scheme])	// sanity check on the URL
			{
                /* Play the movie/audio with the specified URL. */
                MyMovieViewController *movieController = [[MyMovieViewController alloc] initWithStreamURL:dataURL];
                
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:movieController animated:YES];
			}
		}
    }
    else if ([[fpcObjects objectAtIndex:indexPath.row] isKindOfClass:[SeriesObject class]])
    {
        NewsViewController *nvc = [[NewsViewController alloc] init];
        [nvc addDataObjects:((SeriesObject*)[fpcObjects objectAtIndex:indexPath.row]).childObjects];
        [nvc setSeriesObject:((SeriesObject*)[fpcObjects objectAtIndex:indexPath.row])];
        
        [self.navigationController pushViewController:nvc animated:YES];
    }
}

@end




