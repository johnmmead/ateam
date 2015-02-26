//
//  GradientView.h
//  ateam
//
//  Created by Ryan Jennings on 10/23/14.
//  Copyright (c) 2014 Ancestry.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;
@property (nonatomic, retain) NSArray *colors;
@property (nonatomic, retain) NSArray *locations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic, copy) NSString *type;

@end
