//
//  FoursquareAPIClient.m
//  NearbyVenues
//
//  Created by koogawa on 2014/07/05.
//
//

#import "FoursquareAPIClient.h"
#import <CoreLocation/CoreLocation.h>

@implementation FoursquareAPIClient

static NSString * const kFoursquareAPIBaseURLString = @"https://api.foursquare.com/v2";
static NSString * const kFoursquareAPIAccessToken   = @"(YourAccessToken)";
static NSString * const kFoursquareAPIVesion        = @"20140706";
static NSString * const kFoursquareAPILimitCount    = @"50";

+ (instancetype)sharedInstance
{
    static FoursquareAPIClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FoursquareAPIClient alloc] init];
    });
    return sharedInstance;
}

- (void)searchVenuesWithLocation:(CLLocation *)location
                      completion:(void (^)(NSDictionary *result, NSError *error))block
{
	// 緯度・経度・標高取得
	CLLocationDegrees latitude = location.coordinate.latitude;
	CLLocationDegrees longitude = location.coordinate.longitude;
    CLLocationDistance altitude = location.altitude;

    // パラメータを設定
    NSDictionary *parameters = @{@"ll"          : [NSString stringWithFormat:@"%f,%f", latitude, longitude],
                                 @"alt"         : [NSString stringWithFormat:@"%f", altitude],
                                 @"limit"       : kFoursquareAPILimitCount,
                                 @"oauth_token" : kFoursquareAPIAccessToken,
                                 @"v"           : kFoursquareAPIVesion};

    NSString *urlString = [kFoursquareAPIBaseURLString stringByAppendingString:@"/venues/search"];

    FSNConnection *connection =
    [FSNConnection withUrl:[NSURL URLWithString:urlString]
                    method:FSNRequestMethodGET
                   headers:nil
                parameters:parameters
                parseBlock:^id(FSNConnection *c, NSError **error) {
                    return [c.responseData dictionaryFromJSONWithError:error];
                }
           completionBlock:^(FSNConnection *c) {
               if (block) block((NSDictionary *)c.parseResult, c.error);
           }
             progressBlock:nil];
    [connection start];
}

@end
