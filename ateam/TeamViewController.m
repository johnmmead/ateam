//
//  TeamViewController.m
//  ateam
//
//  Created by Ryan Jennings on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "TeamViewController.h"

#import "GradientView.h"
#import "ProfileImageView.h"
#import "SCLAlertView.h"
#import "TeamViewCell.h"
#import "UIColor+ateam.h"
#import "UIFont+ateam.h"
#import "Team.h"
#import "Person.h"

NSString *const TeamName = @"TeamName";
NSString *const TeamDescription = @"TeamDescription";

@interface TeamViewController () <ProfileImageViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet GradientView *backgroundView;
@property (nonatomic, weak) IBOutlet UIView *patternView;
@property (nonatomic, weak) IBOutlet ProfileImageView *profile1View;
@property (nonatomic, weak) IBOutlet ProfileImageView *profile2View;
@property (nonatomic, weak) IBOutlet ProfileImageView *profile3View;
@property (nonatomic, weak) IBOutlet ProfileImageView *profile4View;
@property (nonatomic, weak) IBOutlet ProfileImageView *profile5View;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSArray *teams;
@property (nonatomic, strong) Team *selectedTeam;
@property (nonatomic, assign) BOOL animate;

@end

@implementation TeamViewController {
    BOOL showAddPhoto;
    BOOL showAddMemorial;
    BOOL showViewMemorial;
    BOOL showAll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData]; //populates the teams property
    if(!self.selectedDeviceId){self.selectedDeviceId = @"14501";} //whatever
    
    // set the selected team based on the device id
    for(Team *team in self.teams){
        if([team.deviceId isEqualToString:self.selectedDeviceId]){
            self.selectedTeam = team;
        }
    }
    
    // populate the table
    _tableData = [NSArray arrayWithObjects:self.selectedTeam.name, self.selectedTeam.info, nil];
    _animate = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor whiteColor];
    
    _backgroundView.colors = @[[UIColor ateamRed], [UIColor ateamDarkRed], [UIColor ateamDarkestRed]];
    _patternView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sci-fi_metal_wall"]];
    _patternView.alpha = 0.2;
    
    NSArray *profiles = @[_profile1View, _profile2View, _profile3View, _profile4View, _profile5View];
    
    [self animateProfiles:profiles];
    [self styleProfiles:profiles];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _animate = NO;
}



- (void)animateProfiles:(NSArray *)profiles
{
    _profile1View.goUp = NO;
    _profile2View.goUp = YES;
    _profile3View.goUp = NO;
    _profile4View.goUp = NO;
    _profile5View.goUp = NO;
    for (unsigned i = 0; i < profiles.count; i++) {
        ProfileImageView *view = profiles[i];
        view.duration = 1.0 + ((arc4random() % 20)/10.0f);
        [self toggleView:view];
    }
}


- (void)populateProfiles:(NSArray *)profiles
{
    _profile1View.goUp = NO;
    _profile2View.goUp = YES;
    _profile3View.goUp = NO;
    _profile4View.goUp = NO;
    _profile5View.goUp = NO;
    for (unsigned i = 0; i < profiles.count; i++) {
        ProfileImageView *view = profiles[i];
        view.duration = 1.0 + ((arc4random() % 20)/10.0f);
        [self toggleView:view];
    }
}

- (void)toggleView:(ProfileImageView *)view
{
    if (_animate) {
        [UIView animateWithDuration:view.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
            if (view.goUp) {
                view.center = CGPointMake(view.center.x, view.center.y - 20.0);
                view.goUp = NO;
            } else {
                view.center = CGPointMake(view.center.x, view.center.y + 20.0);
                view.goUp = YES;
            }
        } completion:^(BOOL finished) {
            [self toggleView:view];
        }];
    }
}

- (void)styleProfiles:(NSArray *)profiles
{
    for (unsigned i = 0; i < profiles.count; i++) {
        ProfileImageView *view = profiles[i];
        view.delegate = self;
        view.backgroundColor = [UIColor lightGrayColor];
        view.layer.cornerRadius = 45;
        view.clipsToBounds = YES;
        view.layer.borderWidth = 4;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    _profile2View.layer.cornerRadius = 80;
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamViewCell *cell = (TeamViewCell *)[tableView dequeueReusableCellWithIdentifier:TeamName];
    cell.backgroundColor = [UIColor clearColor];
    cell.label.text = _tableData[indexPath.row];
    cell.label.textColor = indexPath.row == 0 ? [UIColor ateamRed] : [UIColor whiteColor];
    cell.label.font = indexPath.row == 0 ? [UIFont exoLightFontOfSize:40] : [UIFont exoMediumFontOfSize:16];
    cell.label.shadowColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.25];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 60 : 200;
}

#pragma mark - ProfileImageViewDelegate

- (void)profileImageViewWasTapped:(ProfileImageView *)view
{
    [self showAlert];
}

- (void)showAlert
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    blurView.alpha = 0;
    
    [self.view addSubview:blurView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(blurView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:0 metrics:nil views:views]];
    
    [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
        blurView.alpha = 1;
    } completion:nil];
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.backgroundType = Transparent;
    [alert addButton:@"Email" actionBlock:^{
        
    }];
    [alert showCustom:self image:nil color:[UIColor ateamRed] title:@"Title" subTitle:@"Subtitle" closeButtonTitle:@"Close" duration:0];
    [alert alertIsDismissed:^{
        [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
            blurView.alpha = 0;
        } completion:^(BOOL finished) {
            [blurView removeFromSuperview];
        }];
    }];
}

- (void)refresh
{
    [_tableView reloadData];
}

@end
