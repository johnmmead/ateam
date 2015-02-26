//
//  UIFont+ateam.m
//  ateam
//
//  Created by Ryan Jennings on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "UIFont+ateam.h"

NSString *const ExoBlack = @"Exo-Black";
NSString *const ExoBlackItalic = @"Exo-BlackItalic";
NSString *const ExoBold = @"Exo-Bold";
NSString *const ExoBoldItalic = @"Exo-BoldItalic";
NSString *const ExoExtraBold = @"Exo-ExtraBold";
NSString *const ExoExtraBoldItalic = @"Exo-ExtraBoldItalic";
NSString *const ExoExtraLight = @"Exo-ExtraLight";
NSString *const ExoExtraLightItalic = @"Exo-ExtraLightItalic";
NSString *const ExoItalic = @"Exo-Italic";
NSString *const ExoLight = @"Exo-Light";
NSString *const ExoLightItalic = @"Exo-LightItalic";
NSString *const ExoMedium = @"Exo-Medium";
NSString *const ExoMediumItalic = @"Exo-MediumItalic";
NSString *const ExoRegular = @"Exo-Regular";
NSString *const ExoSemiBold = @"Exo-SemiBold";
NSString *const ExoSemiBoldItalic = @"Exo-SemiBoldItalic";
NSString *const ExoThin = @"Exo-Thin";
NSString *const ExoThinItalic = @"Exo-ThinItalic";

@implementation UIFont (ateam)

+ (UIFont *)exoBlackFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoBlack size:size];
}

+ (UIFont *)exoBlackItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoBlackItalic size:size];
}

+ (UIFont *)exoBoldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoBold size:size];
}

+ (UIFont *)exoBoldItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoBoldItalic size:size];
}

+ (UIFont *)exoExtraBoldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoExtraBold size:size];
}

+ (UIFont *)exoExtraBoldItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoExtraBoldItalic size:size];
}

+ (UIFont *)exoExtraLightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoExtraLight size:size];
}

+ (UIFont *)exoExtraLightItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoExtraLightItalic size:size];
}

+ (UIFont *)exoItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoItalic size:size];
}

+ (UIFont *)exoLightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoLight size:size];
}

+ (UIFont *)exoLightItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoLightItalic size:size];
}

+ (UIFont *)exoMediumFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoMedium size:size];
}

+ (UIFont *)exoMediumItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoMediumItalic size:size];
}

+ (UIFont *)exoRegularFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoRegular size:size];
}

+ (UIFont *)exoSemiBoldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoSemiBold size:size];
}

+ (UIFont *)exoSemiBoldItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoSemiBoldItalic size:size];
}

+ (UIFont *)exoThinFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoThin size:size];
}

+ (UIFont *)exoThinItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:ExoThinItalic size:size];
}

@end
