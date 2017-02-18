//
//  MusicList.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/7/18.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import "MusicListManager.h"
#import "Utils.h"

static MusicListManager *sharedInstance;

@implementation MusicListManager

/**
 *  创建全局唯一的音乐列表对象
 *
 *  @return 音乐列表对象
 */
+(MusicListManager *)sharedMusicListManager
{
    if (sharedInstance==NULL)
    {
        sharedInstance = [[MusicListManager alloc] init];
    }
    return sharedInstance;
}

-(NSTimer *)timer
{
    if(!_timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.f target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  创建音乐播放列表数组
 *
 *  @return 数组
 */
-(NSArray *)musicList
{
    if(!_musicList)
    {
        self.musicList = [MJMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musicList;
}

/**
 *  在锁屏界面显示歌曲信息
 *
 *  @param music <#music description#>
 */
-(void)showInfoInLockedScreen:(MJMusic *)music
{
//    NSLog(@"%@",music.name);
    //在锁屏界面显示此歌信息
    self.info = [NSMutableDictionary dictionary];
    
    //标题
    self.info[MPMediaItemPropertyTitle] = music.name;
    
    //作者
    self.info[MPMediaItemPropertyArtist] = music.singer;
    
    //专辑
    self.info[MPMediaItemPropertyAlbumTitle] = music.name;
    
    //音乐总时长
    self.info[MPMediaItemPropertyPlaybackDuration] = [NSNumber numberWithDouble:self.currentPlayingAudioPlayer.duration];
    
    //图片
    self.info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:music.icon]];
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = self.info;

}

/**
 *  实时更新(1秒种更新60次)
 */
-(void)update
{
    //音乐当前已经过时间
    self.info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = [NSNumber numberWithDouble:self.currentPlayingAudioPlayer.currentTime];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:self.info];
}

/**
 *  开始播放
 *
 *  @param index tableView的单元格索引
 */
-(void)playMusicWithIndex:(int)index
{
    self.currentPlayingMusicInfo = _musicList[index];
    if(index == _isPlayingMusicIndex && _currentPlayingMusicInfo.isPlaying == YES)
    {
        return;
    }
    
    [self stopMusicWithIndex:_isPlayingMusicIndex];
    _currentPlayingMusicInfo.playing = YES;
    self.currentPlayingAudioPlayer = [AudioTool playMusic:_currentPlayingMusicInfo.filename];
    self.currentPlayingAudioPlayer.delegate = self;
    self.isPlayingMusicIndex = index;
    [[NSNotificationCenter defaultCenter] postNotificationName:k_refreshPlayingMusicList object:nil];
    
    //开启定时器监听播放进度
    [self.timer invalidate];
    self.timer = nil;
    
    //在锁屏界面显示歌曲更新
    [self showInfoInLockedScreen:_currentPlayingMusicInfo];
    [self.timer fire];
}

/**
 *  停止播放
 *
 *  @param index tableView的单元格索引
 */
-(void)stopMusicWithIndex:(int)index
{
    MJMusic *music = _musicList[index];
    music.playing = NO;
    [AudioTool stopMusic:music.filename];
    self.lastPlayingMusicIndex = index;
}

/**
 *  暂停或播放当前音乐
 */
-(void)pauseOrPlayCurrentPlayingAudioPlayer
{
    if(self.currentPlayingAudioPlayer.isPlaying)
    {
         [self.currentPlayingAudioPlayer pause];
        self.currentPlayingMusicInfo.playing = NO;
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        [self.currentPlayingAudioPlayer play];
        self.currentPlayingMusicInfo.playing = YES;
        [self.timer fire];
    }
}

#pragma mark - AVAudioPlayerDelegate

/**
 *  音乐已经播放结束
 *
 */
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self playNextMusic];
}

/**
 *  音乐被中断（打、接电话）
 *
 *  @param player 电话打进来时对应的播放器
 */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    NSLog(@"audioPlayerBeginInterruption---被打断");
    
}

/**
 *  播放下一首音乐
 */
-(void)playNextMusic
{
    //计算下一行
    int nextRow = self.isPlayingMusicIndex+1;
    if(nextRow == _musicList.count)
    {
        nextRow = 0;
    }
    
    [self playMusicWithIndex:nextRow];
}

/**
 *  播放上一首音乐
 */
-(void)playPreviousMusic
{
    int previousRow = self.isPlayingMusicIndex-1;
    if(previousRow == -1)
    {
        previousRow = (int)_musicList.count-1;
    }
    [self playMusicWithIndex:previousRow];
}

@end
