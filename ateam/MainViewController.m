//
//  MainViewController.m
//  ateam
//
//  Created by Shengzhe Chen on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "MainViewController.h"
#import "Speecher.h"

@interface MainViewController () < ESTBeaconManagerDelegate >
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
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
    [self setupBeaconManager];
}

- (void)setupBeaconManager
{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.avoidUnknownStateBeacons = YES;
    
    ESTBeaconRegion *region = [[ESTBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:purpleUUID] major:purpleMajor minor:purpleMinor identifier:purpleIdentifier];
    [self.beaconManager startMonitoringForRegion:region];
    [self.beaconManager requestStateForRegion:region];
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
