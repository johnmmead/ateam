//
//  ProfileImageView.m
//  ateam
//
//  Created by Ryan Jennings on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "ProfileImageView.h"

@interface ProfileImageView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation ProfileImageView

- (void)awakeFromNib
{
    self.userInteractionEnabled = YES;
    [self configureTapGesture];
}

- (void)configureTapGesture
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:_tap];
    _tap.delegate = self;
}

- (void)didTap:(UIGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(profileImageViewWasTapped:)]) {
        [_delegate profileImageViewWasTapped:self];
    }
}

@end
