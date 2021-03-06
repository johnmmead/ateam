//
//  MainViewController.m
//  ateam
//
//  Created by Shengzhe Chen on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "MainViewController.h"
#import "TeamViewController.h"
#import "Speecher.h"
#import <AVFoundation/AVFoundation.h>
#import "UIColor+ateam.h"

@interface MainViewController () < ESTBeaconManagerDelegate >
@property (weak, nonatomic) IBOutlet UIView *teamContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) TeamViewController *teamViewController;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (nonatomic, strong) NSArray *beaconsArray;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSArray *teamModels;
@property (strong, nonatomic) Team *previousTeam;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Sound nuk];
    [self playBackgroundMusic];

    [self loadTeams];
    
    self.view.backgroundColor = [UIColor ateamDarkestRed];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //[Speecher speak:@"My name is Luca. I live on the second floor." forGender:@"female"];
   // [Speecher speak:@"My name is Gann. You may remember me from such television specials as, learning to wakeboard." forGender:@"male"];
    [self setupBeaconManager];
//    [self performSegueWithIdentifier:@"SegueToTeam" sender:self];
}

- (void)loadTeams
{
    NSArray *(^getPeopleWithTeamId)(NSString *teamId) = ^NSArray*(NSString *teamId) {
        NSMutableArray *people = [NSMutableArray new];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Person" ofType:@"json"];
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        NSError *error =  nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        NSArray *items = [json valueForKeyPath:@"Person"];
        for (NSDictionary *item in items) {
            NSString *tid = [item objectForKey:@"teamId"];
            if([teamId isEqualToString:tid]){
                Person *person = [[Person alloc] init];
                person.teamId = tid;
                person.name = [item objectForKey:@"name"];
                person.info = [item objectForKey:@"info"];
                person.phone= [item objectForKey:@"phone"];
                person.email = [item objectForKey:@"email"];
                person.image = [item objectForKey:@"image"];
                person.gender = [item objectForKey:@"gender"];
                [people addObject:person];
            }
        }
        return people;
    };
    
    NSMutableArray *teams = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Team" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSArray *items = [json valueForKeyPath:@"Team"];
    for (NSDictionary *item in items) {
        Team *team = [[Team alloc] init];
        team.name = [item objectForKey:@"name"];
        team.info = [item objectForKey:@"info"];
        team.teamId = [item objectForKey:@"teamId"];
        team.deviceId = [[item objectForKey:@"deviceId"] integerValue];
        team.people = getPeopleWithTeamId(team.teamId);
        [teams addObject:team];
    }
    
    self.teamModels = teams;
}

- (void)setupBeaconManager
{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.returnAllRangedBeaconsAtOnce = YES;
    self.beaconManager.avoidUnknownStateBeacons = YES;
    
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"Estimote Devices"];
    [self startRangingBeacons];
}

- (void)startRangingBeacons
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TeamViewControllerSegueIdentifier"]) {
        self.teamViewController = segue.destinationViewController;
        self.teamViewController.view.alpha = 0.0f;
    } else {
        [super prepareForSegue:segue sender:sender];
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
    ESTBeacon *closestBeacon = nil;
    NSNumber *maxNumber = [NSNumber numberWithDouble:1000000.0];
    
    for (ESTBeacon *b in beacons) {
        if (b.distance.doubleValue < maxNumber.doubleValue) {
            closestBeacon = b;
            maxNumber = b.distance;
        }
    }
    
    if (closestBeacon && closestBeacon.distance.doubleValue < 1.2f && !self.teamViewController.busy) {
        Team *team = nil;
        for (Team *t in self.teamModels) {
            if (t.deviceId == closestBeacon.minor.integerValue) {
                team = t;
                break;
            }
        }
        
        if (team) {
            [self presentTeam:team];
        }
    }
}

- (void)presentTeam:(Team *)team
{
    if (team != self.previousTeam) {
        self.previousTeam = team;
        __block TeamViewController *teamViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TeamViewControllerStoryboardIdentifier"];
        teamViewController.selectedTeam = team;
        
        __block BOOL isFirstLoad = self.backgroundImageView.alpha > 0;
        teamViewController.view.frame = self.teamViewController.view.frame;
        teamViewController.view.alpha = 0.3;
        [teamViewController willMoveToParentViewController:self];
        [self addChildViewController:teamViewController];
        [teamViewController didMoveToParentViewController:self];
        [self.teamViewController willMoveToParentViewController:nil];
        void (^f)(void) = ^() {
            [UIView animateWithDuration:1.2f animations:^{
                teamViewController.view.alpha = 1.0f;
                self.teamViewController.view.alpha = 0;
            } completion:^(BOOL finished) {
                teamViewController.view.alpha = 1.0f;
            }];
            
            [self transitionFromViewController:self.teamViewController toViewController:teamViewController duration:0.8f options:(isFirstLoad ? UIViewAnimationOptionCurveEaseInOut: UIViewAnimationOptionTransitionFlipFromLeft) animations:nil completion:^(BOOL finished) {
                [teamViewController didMoveToParentViewController:self];
                [self.teamViewController didMoveToParentViewController:nil];
                self.teamViewController = teamViewController;
            }];
        };
        
        if (isFirstLoad) {
            [UIView animateWithDuration:0.6f animations:^{
                self.backgroundImageView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.backgroundImageView.alpha = 0.0;
                f();
            }];
        } else {
            f();
        }
    }

}

- (void)beaconManager:(ESTBeaconManager *)manager didStartMonitoringForRegion:(ESTBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)beaconManagerDidStartAdvertising:(ESTBeaconManager *)manager error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)playBackgroundMusic
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"ateam" ofType:@"mp3"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer setVolume:0.2];
    [self.audioPlayer play];
}

- (IBAction)didTapButton1:(id)sender
{
    //    @"14501";
    Team *team = nil;
    
    for (Team *t in self.teamModels) {
        if (t.deviceId == 14501) {
            team = t;
            break;
        }
    }
    
    if (team) {
        [self presentTeam:team];
    }
}

- (IBAction)didTapButton2:(id)sender
{
//    @"14503";
    
    Team *team = nil;
    
    for (Team *t in self.teamModels) {
        if (t.deviceId == 14503) {
            team = t;
            break;
        }
    }
    
    if (team) {
        [self presentTeam:team];
    }
}

- (IBAction)didTapButton3:(id)sender
{
//     @"14502";

    Team *team = nil;
    
    for (Team *t in self.teamModels) {
        if (t.deviceId == 14502) {
            team = t;
            break;
        }
    }
    
    if (team) {
        [self presentTeam:team];
    }

}

@end
