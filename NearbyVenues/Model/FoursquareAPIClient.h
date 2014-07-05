//
//  FoursquareAPIClient.h
//  NearbyVenues
//
//  Created by koogawa on 2014/07/05.
//
//

//#import <Foundation/Foundation.h>
#import "FSNConnection.h"

@class CLLocation;

@interface FoursquareAPIClient : FSNConnection

+ (instancetype)sharedInstance;

- (void)searchVenuesWithLocation:(CLLocation *)location
                      completion:(void (^)(NSDictionary *result, NSError *error))block;

@end
