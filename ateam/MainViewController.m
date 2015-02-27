//
//  MainViewController.m
//  ateam
//
//  Created by Shengzhe Chen on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "MainViewController.h"
#import "Speecher.h"

#import "ESTBeaconTableVC.h"

@interface MainViewController () < ESTBeaconManagerDelegate >
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (nonatomic, strong) NSArray *beaconsArray;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Sound nuk];
    [Sound schwit];
    [Sound ding];
    [Sound ping];
    //[Speecher speak:@"My name is Luca. I live on the second floor." forGender:@"female"];
    [Speecher speak:@"My name is Gann. You may remember me from such television specials as, learning to wakeboard." forGender:@"male"];    
    [self setupBeaconManager];
}

- (void)setupBeaconManager
{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.returnAllRangedBeaconsAtOnce = YES;
    
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:nil];
    [self startRangingBeacons];
}

-(void)startRangingBeacons
{
    if ([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            [self.beaconManager startRangingBeaconsInRegion:self.region];
        } else {
            [self.beaconManager requestAlwaysAuthorization];
        }
    } else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        [self.beaconManager startRangingBeaconsInRegion:self.region];
    } else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Access Denied"
                                                        message:@"You have denied access to location services. Change this in app settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Available"
                                                        message:@"You have no access to location services."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}


#pragma mark ESTBeaconManagerDelegate
- (void)beaconManager:(ESTBeaconManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManager:(ESTBeaconManager *)manager didDetermineState:(CLRegionState)state forRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManager:(ESTBeaconManager *)manager didStartMonitoringForRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManagerDidStartAdvertising:(ESTBeaconManager *)manager error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
