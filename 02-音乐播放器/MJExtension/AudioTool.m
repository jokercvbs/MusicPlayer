//
//  AudioTool.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/15.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import "AudioTool.h"


/**
 *  存放所有的音乐播放器
 *  字典：filename作为key,audioPalyer作为value;
 */
static NSMutableDictionary *_audioPlayerDict;

@implementation AudioTool

/**
 *  初始化
 */
+(void)initialize
{
    _audioPlayerDict = [NSMutableDictionary dictionary];

}

/**
 *  播放音乐
 *
 *  @param fileName 音乐文件名
 */
+(AVAudioPlayer *)playMusic:(NSString*)fileName
{
    if(!fileName)return nil;
    //1、从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[fileName];
    
    //由于当前方法是类方法，self代表类不是对象。所以下面这句代码是错误的
    //audioPlayer.delegate = self;
    
    if(!audioPlayer)
    {
        //创建音乐文件路径
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if(!url)return nil;
        
        //创建audioPlayer
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
//        //允许切换歌曲播放速度
//        audioPlayer.enableRate = YES;

//        //调整播放速率为10倍，用于检测连续播放
//        audioPlayer.rate = 40;
//
        //缓冲
        [audioPlayer prepareToPlay];
        
        //放入字典
        _audioPlayerDict[fileName] = audioPlayer;
    }
    //2、播放
    [audioPlayer play];
    return audioPlayer;
}

/**
 *  暂停音乐
 *
 *  @param fileName 音乐文件名
 */
+(void)pauseMusic:(NSString*)fileName
{
    if (!fileName)return;
    
    //从字典中获取audioPlayer;
    AVAudioPlayer *audioPlayer = _audioPlayerDict[fileName];
    if(!audioPlayer)return;
    
    //如果当前播放器正在播放音乐就暂停
    if(audioPlayer.isPlaying)
        [audioPlayer pause];
}

/**
 *  停止播放音乐
 *
 *  @param fileName 音乐文件名
 */
+(void)stopMusic:(NSString*)fileName
{
    if (!fileName)return;
    
    //1、从字典中获取audioPlayer;
    AVAudioPlayer *audioPlayer = _audioPlayerDict[fileName];
    if(!audioPlayer)return;
    
    //2、如果当前播放器正在播放音乐就停止
    if(audioPlayer.isPlaying)
    {
        [audioPlayer stop];
        //当音乐停止了播放器就不能使用了，从字典中移除
        [_audioPlayerDict removeObjectForKey:fileName];
    }
}



@end
