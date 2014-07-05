//
//  VenueModel.m
//  NearbyVenues
//
//  Created by koogawa on 2014/07/06.
//
//

#import "VenueModel.h"

@implementation VenueModel

- (instancetype)initWithJSONDictionary:(NSDictionary *)json
{
    NSString *venueId = json[@"id"];
    NSString *name = json[@"name"];
	NSString *address = json[@"location"][@"address"];
    NSNumber *distance = json[@"location"][@"distance"];
	NSNumber *hereNow = json[@"hereNow"][@"count"];

    return [self initWithVenueId:venueId name:name address:address distance:distance hereNow:hereNow];
}

- (instancetype)initWithVenueId:(NSString *)venueId
                           name:(NSString *)name
                        address:(NSString *)address
                       distance:(NSNumber *)distance
                        hereNow:(NSNumber *)hereNow
{
    self = [super init];
    if (self) {
        _venueId = venueId;
        _name = name;
        _address = address;
        _distance = distance;
        _hereNow = hereNow;
    }
    
    return self;
}

@end
