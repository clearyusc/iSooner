//
//  ResourcesViewController.m
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResourcesViewController.h"
#import "Constants.h"
#import "NewsViewController.h"
#import "DataObject.h"
#import "SeriesObject.h"
#import "MyMovieViewController.h"
#import "CustomCell.h"

@interface ResourcesViewController ()

@end

@implementation ResourcesViewController

@synthesize filterControl, tableView, resourcesObjects, segmentDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = @"Resources";
        self.tabBarItem.image = [UIImage imageNamed:@"globe"];
        
        // Initialize the data arrays
        resourcesObjects = [[NSMutableArray alloc] init];
        segmentDictionary = [[NSMutableDictionary alloc] init];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kSermonsElementName];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kDevotionalsElementName];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kApologeticsElementName];
        [segmentDictionary setObject:[[NSMutableArray alloc] init] forKey:kOtherElementName];

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

- (void) addSeriesObjects:(NSArray*)seriesObjects intoSegment:(NSString *)segment
{
    
    if ([segment isEqualToString:kSermonsElementName])
    {
        [[self.segmentDictionary objectForKey:kSermonsElementName] addObjectsFromArray:seriesObjects];
    }
    else if ([segment isEqualToString:kDevotionalsElementName])
    {
        [[self.segmentDictionary objectForKey:kDevotionalsElementName] addObjectsFromArray:seriesObjects];
    }
    else if ([segment isEqualToString:kApologeticsElementName])
    {
        [[self.segmentDictionary objectForKey:kApologeticsElementName] addObjectsFromArray:seriesObjects];
    }
    else if ([segment isEqualToString:kOtherElementName])
    {
        [[self.segmentDictionary objectForKey:kOtherElementName] addObjectsFromArray:seriesObjects];
    }
    
    // Make sure you are showing the correct data for the segment you are currently in
    [self updateSegments];
    [tableView reloadData];
}

-(void)updateSegments
{
    switch (filterControl.selectedSegmentIndex) {
        case 0: // Sermons
            resourcesObjects = [self.segmentDictionary objectForKey:kSermonsElementName];
            [tableView reloadData];
            break;
        case 1: // Devotionals
            resourcesObjects = [self.segmentDictionary objectForKey:kDevotionalsElementName];
            [tableView reloadData];
            break;
        case 2: // Apologetics
            resourcesObjects = [self.segmentDictionary objectForKey:kApologeticsElementName];
            [tableView reloadData];
            break;
        case 3: // Other
            resourcesObjects = [self.segmentDictionary objectForKey:kOtherElementName];
            [tableView reloadData];
            break;
            
        default:
            break;
    }
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
    return resourcesObjects.count;
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
    
    if ([((AppObject*)[resourcesObjects objectAtIndex:indexPath.row]) isKindOfClass:[DataObject class]])
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
            customCell.titleLabel.text = ((AppObject*)[resourcesObjects objectAtIndex:indexPath.row]).title;
            customCell.scriptureLabel.text = ((DataObject*)[resourcesObjects objectAtIndex:indexPath.row]).scripture;
            customCell.authorLabel.text = ((DataObject*)[resourcesObjects objectAtIndex:indexPath.row]).author;
            customCell.monthLabel.text = ((DataObject*)[resourcesObjects objectAtIndex:indexPath.row]).month;
            customCell.dayLabel.text = ((DataObject*)[resourcesObjects objectAtIndex:indexPath.row]).day;
            
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
            cell.textLabel.text = ((SeriesObject*)[resourcesObjects objectAtIndex:indexPath.row]).title;
            NSURL *url = [NSURL URLWithString:((SeriesObject*)[resourcesObjects objectAtIndex:indexPath.row]).imageURLString];
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
    if ([[resourcesObjects objectAtIndex:indexPath.row] isKindOfClass:[DataObject class]])
    {
        NSURL *dataURL = ((DataObject*)[resourcesObjects objectAtIndex:indexPath.row]).link;
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
    else if ([[resourcesObjects objectAtIndex:indexPath.row] isKindOfClass:[SeriesObject class]])
    {
        NewsViewController *nvc = [[NewsViewController alloc] init];
        [nvc addDataObjects:((SeriesObject*)[resourcesObjects objectAtIndex:indexPath.row]).childObjects];
        [nvc setSeriesObject:((SeriesObject*)[resourcesObjects objectAtIndex:indexPath.row])];
        
        [self.navigationController pushViewController:nvc animated:YES];
    }
}

@end





