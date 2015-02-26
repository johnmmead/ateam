//
//  Sound.m
//  ateam
//
//  Created by John Mead on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "Sound.h"

static SystemSoundID _nuk;
static SystemSoundID _ping;
static SystemSoundID _schwit;
static SystemSoundID _dingSound;

@implementation Sound

+ (void)nuk
{
    if(!_nuk){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"nuk" ofType:@"aiff"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: path], &_nuk);
    }
    AudioServicesPlaySystemSound(_nuk);
}

+ (void)ping
{
    if(!_ping){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ping" ofType:@"aiff"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: path], &_ping);
    }
    AudioServicesPlaySystemSound(_ping);
}

+ (void)schwit
{
    if(!_schwit){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"schwit" ofType:@"aiff"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: path], &_schwit);
    }
    AudioServicesPlaySystemSound(_schwit);
}

+ (void)ding
{
    if(!_dingSound){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ding" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: path], &_dingSound);
    }
    AudioServicesPlaySystemSound(_dingSound );
}

@end
