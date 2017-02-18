//
//  MusicPlayerController.h
//  02-音乐播放器
//
//  Created by 林信成 on 16/7/9.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicsViewController.h"

@interface MusicPlayerController : UIViewController
@property(nonatomic, strong)CADisplayLink *link;
@property(nonatomic, strong)CADisplayLink *discRotateLink;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UISlider *musicPlayProgressSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationTimeLabel;
@property (strong, nonatomic) UILabel *navTitle;
@property (strong, nonatomic) UILabel *navDetailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *discMask;
@property (weak, nonatomic) IBOutlet UIImageView *blackDisc;
- (IBAction)previousMusic:(id)sender;
- (IBAction)nextMusic:(id)sender;
- (IBAction)pauseOrPlay:(id)sender;
- (IBAction)dragMusicPlayProgressSlider:(id)sender;
- (IBAction)sliderTouchisBegin:(id)sender;
- (IBAction)sliderTouchisEnd:(id)sender;
@end
