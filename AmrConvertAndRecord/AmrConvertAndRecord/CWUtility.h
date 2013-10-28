//
//  CWUtility.h
//  AmrConvertAndRecord
//
//  Created by Holyen Zou on 13-10-28.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioToolbox/AudioToolbox.h"

@interface CWUtility : NSObject <AVAudioRecorderDelegate>

@property (assign, nonatomic) NSInteger maxRecordTime;//最大录音时间

@property (copy, nonatomic) NSString *recordFileName;

@property (copy, nonatomic) NSString *recordFilePath;

@property (retain, nonatomic) AVAudioRecorder *recorder;

+ (NSString *)currentTimeString;

+ (NSString *)voiceDocumentDirectory;

+ (NSString *)voiceCacheDirectory;

+ (BOOL)fileExistsAtPath:(NSString *)aPath;

+ (BOOL)deleteFileAtPath:(NSString *)aPath;

- (void)beginRecordByFileName:(NSString *)aFileName;

+ (NSDictionary*)audioRecorderSettingDict;

@end
