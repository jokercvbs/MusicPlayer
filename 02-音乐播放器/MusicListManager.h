//
//  MusicList.h
//  02-音乐播放器
//
//  Created by 林信成 on 16/7/18.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MJMusic.h"
#import "MJExtension.h"
#import "AudioTool.h"

@interface MusicListManager : NSObject<AVAudioPlayerDelegate>
@property(nonatomic, strong)NSArray *musicList;
@property(nonatomic, assign)int isPlayingMusicIndex;
@property(nonatomic, assign)int lastPlayingMusicIndex;
@property(nonatomic, strong)AVAudioPlayer *currentPlayingAudioPlayer;
@property(nonatomic, strong)MJMusic *currentPlayingMusicInfo;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)NSMutableDictionary *info;

+(MusicListManager*)sharedMusicListManager;
-(NSArray *)musicList;
-(void)playNextMusic;
-(void)playPreviousMusic;
-(void)playMusicWithIndex:(int)index;
-(void)pauseOrPlayCurrentPlayingAudioPlayer;
@end
