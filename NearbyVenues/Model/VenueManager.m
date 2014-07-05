//
//  VenueManager.m
//  NearbyVenues
//
//  Created by koogawa on 2014/07/05.
//
//

#import "VenueManager.h"
#import "FoursquareAPIClient.h"
#import "VenueModel.h"
#import <CoreLocation/CoreLocation.h>

@implementation VenueManager

+ (instancetype)sharedInstance
{
    static VenueManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VenueManager alloc] init];
    });
    return sharedInstance;
}

- (void)searchVenuesWithLocation:(CLLocation *)location
                      completion:(void (^)(NSArray *venues, NSError *error))block
{
    [[FoursquareAPIClient sharedInstance] searchVenuesWithLocation:location
                                                        completion:^(NSDictionary *result, NSError *error)
     {
         NSArray *results = nil;
         if (result) {
             results = [self parseVenues:result[@"response"][@"venues"]];
         }
         if (block) block(results, error);
     }];
}

- (NSArray *)parseVenues:(NSArray *)venues
{
    NSMutableArray *mutableVenues = @[].mutableCopy;
    
    [venues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        VenueModel *venue = [[VenueModel alloc] initWithJSONDictionary:obj];
        [mutableVenues addObject:venue];
    }];
    
    return [mutableVenues copy];
}

@end
