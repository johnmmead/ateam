//
//  Person.h
//  ateam
//
//  Created by John Mead on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *gender;

@end
