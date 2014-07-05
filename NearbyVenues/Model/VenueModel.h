//
//  VenueModel.h
//  NearbyVenues
//
//  Created by koogawa on 2014/07/06.
//
//

#import <Foundation/Foundation.h>

@interface VenueModel : NSObject

@property (nonatomic, readonly) NSString *venueId;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSNumber *hereNow;
@property (nonatomic, readonly) NSNumber *distance;

- (instancetype)initWithJSONDictionary:(NSDictionary *)json;

@end
