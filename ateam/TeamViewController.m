//
//  TeamViewController.m
//  ateam
//
//  Created by Ryan Jennings on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "TeamViewController.h"

#import "GradientView.h"
#import "TeamViewCell.h"
#import "UIColor+ateam.h"
#import "UIFont+ateam.h"

NSString *const TeamName = @"TeamName";
NSString *const TeamDescription = @"TeamDescription";

BOOL showAddPhoto;
BOOL showAddMemorial;
BOOL showViewMemorial;
BOOL showAll;

@interface TeamViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet GradientView *backgroundView;
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
    
    _tableData = [NSArray arrayWithObjects:@"Search Team", @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sagittis mauris placerat leo dignissim viverra. Quisque vehicula, metus ut luctus accumsan, justo dolor suscipit eros, vel rutrum arcu nunc nec arcu. Etiam bibendum dui nibh, ac varius turpis finibus vitae. Nam et auctor felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer non risus lobortis, iaculis nisi nec, pharetra elit.", nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor whiteColor];
    
    _backgroundView.colors = @[[UIColor ateamRed], [UIColor ateamDarkRed], [UIColor ateamDarkestRed]];
    
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

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamViewCell *cell = (TeamViewCell *)[tableView dequeueReusableCellWithIdentifier:TeamName];
    cell.backgroundColor = [UIColor clearColor];
    cell.label.text = _tableData[indexPath.row];
    cell.label.textColor = indexPath.row == 0 ? [UIColor ateamRed] : [UIColor whiteColor];
    cell.label.font = indexPath.row == 0 ? [UIFont exoLightFontOfSize:40] : [UIFont exoMediumFontOfSize:16];
    cell.label.shadowColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.25];
    cell.label.shadowOffset = CGSizeMake(0, 10);
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

@end
