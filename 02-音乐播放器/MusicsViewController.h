//
//  MusicsViewController.h
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/14.
//  Copyright © 2016年 林信成. All rights reserved.
//
#define NEXT 0
#define PREVIOUS 1

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface MusicsViewController : UITableViewController<AVAudioPlayerDelegate>
@property(nonatomic, strong)AVAudioPlayer *currentPlayingAudioPlayer;
@end
