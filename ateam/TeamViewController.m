//
//  TeamViewController.m
//  ateam
//
//  Created by Ryan Jennings on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "TeamViewController.h"

#import "GradientView.h"
#import "UIColor+ateam.h"
#import "UIFont+ateam.h"

NSString *const TeamName = @"TeamName";
NSString *const TeamDescription = @"TeamDescription";

@interface TeamViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet GradientView *backgroundView;
@property (nonatomic, weak) IBOutlet UILabel *profileTitle;
@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIImageView *profile1View;
@property (nonatomic, weak) IBOutlet UIImageView *profile2View;
@property (nonatomic, weak) IBOutlet UIImageView *profile3View;
@property (nonatomic, weak) IBOutlet UIImageView *profile4View;
@property (nonatomic, weak) IBOutlet UIImageView *profile5View;
@property (nonatomic, strong) NSArray *tableData;
@end

@implementation TeamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableData = [NSArray arrayWithObjects:@"Data will go here...", nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor whiteColor];
    
    _profileTitle.font = [UIFont exoBlackFontOfSize:30];
    _profileTitle.text = @"Members of this team!";
    
    _backgroundView.colors = @[[UIColor ateamRed], [UIColor ateamDarkRed], [UIColor ateamDarkestRed]];
    
    [self styleBackButton];
    [self styleProfileImageViews:@[_profile1View, _profile2View, _profile3View, _profile4View, _profile5View]];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)styleProfileImageViews:(NSArray *)imageViews;
{
    for (unsigned i = 0; i < imageViews.count; i++) {
        UIImageView *view = imageViews[i];
        view.backgroundColor = [UIColor lightGrayColor];
        view.layer.cornerRadius = 45;
        view.clipsToBounds = YES;
        view.layer.borderWidth = 4;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    _profile2View.layer.cornerRadius = 80;
}

- (void)styleBackButton
{
    _backButton.layer.cornerRadius = 30;
    _backButton.backgroundColor = [UIColor ateamDarkRed];
    [_backButton setTitle:@"BACK" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont exoMediumFontOfSize:14];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TeamName];
        cell.textLabel.text = _tableData[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont exoMediumFontOfSize:16];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TeamDescription];
        cell.textLabel.text = _tableData[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont exoMediumFontOfSize:16];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
