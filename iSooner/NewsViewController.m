//
//  FirstViewController.m
//  iSooner
//
//  Created by Ryan Cleary on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "CustomCell.h"
#import "Constants.h"
#import "AppObject.h"
#import "DataObject.h"
#import "MyMovieViewController.h"
#import "SeriesObject.h"


@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize banner;
@synthesize tableView;
@synthesize newsDataObjects;
@synthesize seriesObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        //self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"_newspaper"];
        banner.image = [UIImage imageNamed:@"conversion_of_paul.gif"];
        newsDataObjects = [[NSMutableArray alloc] init];
        
        // Set up the table view:
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
        {
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TABLEVIEW_Y_LOCATION_IPAD, self.view.frame.size.width, self.view.frame.size.height - TABLEVIEW_Y_LOCATION_IPAD)];
        }
        else
        {
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TABLEVIEW_Y_LOCATION_IPHONE, self.view.frame.size.width, self.view.frame.size.height - TABLEVIEW_Y_LOCATION_IPHONE)];
        }
        
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:tableView];
        
    }
    
    return self;
}

- (id) initWithSeriesObject:(SeriesObject*)sobject
{
    self = [super init];
    
    if (self)
    {
        newsDataObjects = [[NSMutableArray alloc] init];
        
        // Set up the table view:
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
        {
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TABLEVIEW_Y_LOCATION_IPAD, self.view.frame.size.width, self.view.frame.size.height - TABLEVIEW_Y_LOCATION_IPAD)];
        }
        else
        {
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TABLEVIEW_Y_LOCATION_IPHONE, self.view.frame.size.width, self.view.frame.size.height - TABLEVIEW_Y_LOCATION_IPHONE)];
        }
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:tableView];
        
        self.seriesObject = sobject;
    }
    
    return self;

}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.title = self.seriesObject.title;
    newsDataObjects = [NSArray arrayWithArray:self.seriesObject.childObjects];
    
    // And update the banner's image
    NSURL *url = [NSURL URLWithString:self.seriesObject.imageURLString];
    NSLog(@"NVC viewDidAppear - THE IMAGE URL = %@", url);
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    UIImageView *imageView = [[UIImageView alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
    {
       [imageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, BANNER_HEIGHT_IPAD)];
    }
    else
    {
       [imageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, BANNER_HEIGHT_IPHONE)];
    }
    
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    //[self.banner setImage:image];
    [tableView reloadData];    
}

- (void)viewDidUnload
{
    [self setBanner:nil];
    [self setTableView:nil];
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

-(void) addDataObjects:(NSArray*)dataObjects
{
    newsDataObjects = [NSArray arrayWithArray:dataObjects];
    [tableView reloadData];
}


- (void) addSeriesObjects:(NSArray*)seriesObjects
{
    // Since this is the NEWS section, there is only one series, so load its children in
    
    self.seriesObject = ((SeriesObject*)seriesObjects.lastObject); 
    self.title = self.seriesObject.title;
    newsDataObjects = [NSArray arrayWithArray:self.seriesObject.childObjects];
    
    // And update the banner's image
    NSURL *url = [NSURL URLWithString:self.seriesObject.imageURLString];
    NSLog(@"THE IMAGE URL = %@", url);
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]]; 
    [self.banner setImage:image];
    [tableView reloadData];
}

/*-(void) prepareForPushWithSeriesObject:(SeriesObject *)_seriesObject
{ 
    self.seriesObject = _seriesObject;
    self.title = self.seriesObject.title;
    newsDataObjects = [NSArray arrayWithArray:self.seriesObject.childObjects];
    
    // And update the banner's image
    [self.banner setImage:self.seriesObject.image];
    [tableView reloadData];
}*/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return newsDataObjects.count;
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
    
    /*static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     
     if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     cell.textLabel.text = @"Eternal Word of God";
     cell.detailTextLabel.text = @"Isaiah 40:8";
     
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     }
     
     return cell;
     */
    
    if ([((AppObject*)[newsDataObjects objectAtIndex:indexPath.row]) isKindOfClass:[DataObject class]])
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
            customCell.titleLabel.text = ((AppObject*)[newsDataObjects objectAtIndex:indexPath.row]).title;
            customCell.scriptureLabel.text = ((DataObject*)[newsDataObjects objectAtIndex:indexPath.row]).scripture;
            customCell.authorLabel.text = ((DataObject*)[newsDataObjects objectAtIndex:indexPath.row]).author;
            customCell.monthLabel.text = ((DataObject*)[newsDataObjects objectAtIndex:indexPath.row]).month;
            customCell.dayLabel.text = ((DataObject*)[newsDataObjects objectAtIndex:indexPath.row]).day;
            
        } 
        
        return customCell;
        
    }
    else// if ([[newsDataObjects objectAtIndex:indexPath.row] isKindOfClass:[SeriesObject class]])
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
            cell.textLabel.text = ((SeriesObject*)[newsDataObjects objectAtIndex:indexPath.row]).title;
            NSURL *url = [NSURL URLWithString:((SeriesObject*)[newsDataObjects objectAtIndex:indexPath.row]).imageURLString];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]]; 
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
            {
                [cell.imageView setFrame:CGRectMake(0, 0, SERIES_THUMBNAIL_IPAD, SERIES_THUMBNAIL_IPAD)];
            }
            else
            {
                [cell.imageView setFrame:CGRectMake(0, 0, SERIES_THUMBNAIL_IPHONE, SERIES_THUMBNAIL_IPHONE)];
            }
            
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
    if ([[newsDataObjects objectAtIndex:indexPath.row] isKindOfClass:[DataObject class]])
    {
        NSURL *dataURL = ((DataObject*)[newsDataObjects objectAtIndex:indexPath.row]).link;
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
    else if ([[newsDataObjects objectAtIndex:indexPath.row] isKindOfClass:[SeriesObject class]])
    {
        NewsViewController *nvc = [[NewsViewController alloc] init];
        [nvc addDataObjects:((SeriesObject*)[newsDataObjects objectAtIndex:indexPath.row]).childObjects];
        [nvc setSeriesObject:((SeriesObject*)[newsDataObjects objectAtIndex:indexPath.row])];
        
        [self.navigationController pushViewController:nvc animated:YES];
    }
}


@end

















