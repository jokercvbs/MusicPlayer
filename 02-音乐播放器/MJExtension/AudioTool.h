//
//  AudioTool.h
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/15.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioTool : NSObject
/**
 *  播放音乐
 *
 *  @param fileName 音乐文件名
 */
+(AVAudioPlayer *)playMusic:(NSString*)fileName;

/**
 *  暂停音乐
 *
 *  @param fileName 音乐文件名
 */
+(void)pauseMusic:(NSString*)fileName;

/**
 *  停止播放音乐
 *
 *  @param fileName 音乐文件名
 */
+(void)stopMusic:(NSString*)fileName;

@end
