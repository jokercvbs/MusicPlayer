//
//  MyApplication.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/16.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import "MyApplication.h"
#import "MusicListManager.h"

@implementation MyApplication
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype)
    {
        case UIEventSubtypeRemoteControlPlay:
            [[MusicListManager sharedMusicListManager]pauseOrPlayCurrentPlayingAudioPlayer];
            break;
        case UIEventSubtypeRemoteControlPause:
            [[MusicListManager sharedMusicListManager]pauseOrPlayCurrentPlayingAudioPlayer];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [[MusicListManager sharedMusicListManager]playNextMusic];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [[MusicListManager sharedMusicListManager]playPreviousMusic];

            break;
        default:
            break;
    }
}
@end
