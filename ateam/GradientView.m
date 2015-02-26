//
//  GradientView.m
//  ateam
//
//  Created by Ryan Jennings on 10/23/14.
//  Copyright (c) 2014 Ancestry.com. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

@dynamic gradientLayer;
@dynamic colors, locations, startPoint, endPoint, type;

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (NSArray *)colors
{
    NSArray *cgColors = self.gradientLayer.colors;
    if (cgColors == nil) {
        return nil;
    }
    
    NSMutableArray *uiColors = [NSMutableArray arrayWithCapacity:[cgColors count]];
    for (id cgColor in cgColors) {
        [uiColors addObject:[UIColor colorWithCGColor:(__bridge CGColorRef)cgColor]];
    }
    return [NSArray arrayWithArray:uiColors];
}

- (void)setColors:(NSArray *)newColors
{
    NSMutableArray *newCGColors = nil;
    
    if (newColors != nil) {
        newCGColors = [NSMutableArray arrayWithCapacity:[newColors count]];
        for (id color in newColors) {
            if ([color isKindOfClass:[UIColor class]]) {
                [newCGColors addObject:(id)[color CGColor]];
            } else {
                [newCGColors addObject:color];
            }
        }
    }
    
    self.gradientLayer.colors = newCGColors;
}

- (NSArray *)locations
{
    return self.gradientLayer.locations;
}

- (void)setLocations:(NSArray *)newLocations
{
    self.gradientLayer.locations = newLocations;
}

- (CGPoint)startPoint
{
    return self.gradientLayer.startPoint;
}

- (void)setStartPoint:(CGPoint)newStartPoint
{
    self.gradientLayer.startPoint = newStartPoint;
}

- (CGPoint)endPoint
{
    return self.gradientLayer.endPoint;
}

- (void)setEndPoint:(CGPoint)newEndPoint
{
    self.gradientLayer.endPoint = newEndPoint;
}

- (NSString *)type
{
    return self.gradientLayer.type;
}

- (void) setType:(NSString *)newType
{
    self.gradientLayer.type = newType;
}

@end