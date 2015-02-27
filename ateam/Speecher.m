//
//  Speecher.m
//  ateam
//
//  Created by John Mead on 2/26/15.
//  Copyright (c) 2015 Ancestry.com. All rights reserved.
//

#import "Speecher.h"
#import <AVFoundation/AVFoundation.h>

@implementation Speecher

+ (void)speak:(NSString *)phrase forGender:(NSString *)gender
{
    
    // setting a gender-specific voice
    if(! [gender length]){ gender = @"male"; }
    AVSpeechSynthesisVoice *voice;
    if([[gender lowercaseString] isEqualToString:@"male"])
    {
        voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-gb"];
    } else {
        voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-au"];
    }
    
    // this is a hack to get around a bug in iOS 8 - don't change
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *bugWorkaroundUtterance = [AVSpeechUtterance speechUtteranceWithString:@" "];
    bugWorkaroundUtterance.rate = AVSpeechUtteranceMaximumSpeechRate;
    [synthesizer speakUtterance:bugWorkaroundUtterance];
    
    // this is the code you will hear
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:phrase];
    utterance.rate = 0.23f;
    utterance.voice = voice;
    utterance.preUtteranceDelay = 1.5;

    [synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
    [synthesizer speakUtterance:utterance];
}


@end
