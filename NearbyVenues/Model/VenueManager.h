//
//  VenueManager.h
//  NearbyVenues
//
//  Created by koogawa on 2014/07/05.
//
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface VenueManager : NSObject

@property (nonatomic, assign) BOOL isLoading;

+ (instancetype)sharedInstance;

- (void)searchVenuesWithLocation:(CLLocation *)location
                      completion:(void (^)(NSArray *venues, NSError *error))block;

@end
