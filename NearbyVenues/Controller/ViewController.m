//
//  ViewController.m
//  NearbyVenues
//
//  Created by koogawa on 2014/07/06.
//  Copyright (c) 2014年 Kosuke Ogawa. All rights reserved.
//

#import "ViewController.h"
#import "VenueModel.h"
#import "VenueManager.h"

@interface ViewController ()

@property (nonatomic, strong) CLLocationManager	*locationManager;
@property (nonatomic, strong) NSArray           *venues;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method

// 近くのベニューリストを取得
- (void)searchVenuesWithLocation:(CLLocation *)location
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [[VenueManager sharedInstance] searchVenuesWithLocation:location
                                                 completion:^(NSArray *venues, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

         if (error)
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Couldn't get venue list"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Close"
                                                   otherButtonTitles:nil];
             [alert show];
         }

         self.venues = venues.mutableCopy;
         [self.tableView reloadData];
     }];
}


#pragma mark - CLLocationManager delegate

// 位置が更新されたら呼ばれる
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    // 一度位置情報が取れたらストップ
    [manager stopUpdatingLocation];

    [self searchVenuesWithLocation:newLocation];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.venues count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VenueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    VenueModel *venue = self.venues[indexPath.row];

	// Configure the cell.
	cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.address;

    return cell;
}

@end
