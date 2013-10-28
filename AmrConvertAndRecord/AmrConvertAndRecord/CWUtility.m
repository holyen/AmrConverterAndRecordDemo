//
//  CWUtility.m
//  AmrConvertAndRecord
//
//  Created by Holyen Zou on 13-10-28.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWUtility.h"

@implementation CWUtility

/**
 *	生成当前时间字符串
 *
 *	@return	当前时间字符串
 */
+ (NSString *)currentTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

/**
 *	获取amr音频文件保存的路径
 *
 *	@return	amr音频文件保存的路径
 */
+ (NSString *)voiceDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Voice"];
}

/**
 *	获取音频文件缓存路径
 *
 *	@return	音频文件缓存路径
 */
+ (NSString *)voiceCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Voice"];
}

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString *)aPath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:aPath];
}

/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString *)aPath
{
    return [[NSFileManager defaultManager] removeItemAtPath:aPath error:nil];
}

- (void)beginRecordByFileName:(NSString *)aFileName
{
    NSString *path = [[NSString alloc] initWithFormat:@"%@%@.wav", [CWUtility voiceDocumentDirectory], aFileName];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:path]
                                                settings:[CWUtility audioRecorderSettingDict]
                                                   error:nil];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self.recorder record];
}

/**
 获取录音设置
 [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
 [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
 [NSNumber numberWithInt: AVAudioQualityLow],AVEncoderAudioQualityKey,//音频编码质量
 @returns 录音设置
 */
+ (NSDictionary*)audioRecorderSettingDict
{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   nil];
    return recordSetting;
}

#pragma mark -
#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"录音停止");
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder
{
    NSLog(@"录音开始");
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags
{
    NSLog(@"录音中断");
}


@end
