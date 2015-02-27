//
//  Team.h
//  ateam
//
//  Created by John Mead on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *teamId;
@property (assign, nonatomic) NSUInteger deviceId;
@property (strong, nonatomic) NSArray *people;

@end
