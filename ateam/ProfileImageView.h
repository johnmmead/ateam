//
//  ProfileImageView.h
//  ateam
//
//  Created by Ryan Jennings on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@protocol ProfileImageViewDelegate;

@interface ProfileImageView : UIImageView
@property (nonatomic, weak) id<ProfileImageViewDelegate> delegate;
@property (nonatomic, assign) BOOL goUp;
@property (nonatomic, assign) NSTimeInterval duration;
@property (strong, nonatomic) Person *person;

@end

@protocol ProfileImageViewDelegate <NSObject>

- (void)profileImageViewWasTapped:(ProfileImageView *)view;

@end