//
//  MusicPlayerController.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/7/9.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import "MusicPlayerController.h"
#import "MusicListManager.h"
#import "Utils.h"
@interface MusicPlayerController ()

@end
static UIImage *s_backgroundImage = nil;
@implementation MusicPlayerController

-(CADisplayLink *)link
{
    if(!_link)
    {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}
-(CADisplayLink *)discRotateLink
{
    if(!_discRotateLink)
    {
        self.discRotateLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotateDisc)];
    }
    return _discRotateLink;
}

-(void)rotateDisc
{
    CGFloat angle = self.discRotateLink.duration * M_PI_4;
    self.blackDisc.layer.transform = CATransform3DRotate(self.blackDisc.layer.transform, angle, 0, 0, 1);
}

-(void)update
{
    self.musicPlayProgressSlider.value = [MusicListManager sharedMusicListManager].currentPlayingAudioPlayer.currentTime;
    self.currentTimeLabel.text = [Utils timeFormatWithTimeintervalToMinAndSec:[MusicListManager sharedMusicListManager].currentPlayingAudioPlayer.currentTime];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //自动切换歌曲时，更新界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlayerTimeInfo) name:k_refreshPlayingMusicList object:nil];
    
    //黑碟背景遮罩
    self.discMask.image = [UIImage imageNamed:@"cm2_play_disc_mask"];
    
    //黑碟
    self.blackDisc.image = [Utils circleImage:[UIImage imageNamed:[MusicListManager sharedMusicListManager].currentPlayingMusicInfo.icon] withParam:56];
    
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view setClipsToBounds:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [self updatePlayerTimeInfo];
    [self.link invalidate];
    self.link = nil;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.discRotateLink invalidate];
    self.discRotateLink = nil;
    [self.discRotateLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.musicPlayProgressSlider setThumbImage:[UIImage imageNamed:@"cm2_fm_playbar_btn"] forState:UIControlStateNormal];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_back"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120.f, 44)];
    navTitleView.clipsToBounds = YES;
    
    self.navTitle = [[UILabel alloc] init];
    self.navTitle.text = [MusicListManager sharedMusicListManager].currentPlayingMusicInfo.name;
    self.navTitle.textAlignment = NSTextAlignmentCenter;
    self.navTitle.font = [UIFont systemFontOfSize:15.0f];
    self.navTitle.textColor = [UIColor whiteColor];
    [self.navTitle sizeToFit];
    self.navTitle.layer.anchorPoint = CGPointMake(0.5, 0);
    [self.navTitle setCenter:CGPointMake(navTitleView.frame.size.width*0.5, 0)];
    
    self.navDetailTitle = [[UILabel alloc] init];
    self.navDetailTitle.text = [MusicListManager sharedMusicListManager].currentPlayingMusicInfo.singer;
    self.navDetailTitle.textAlignment = NSTextAlignmentCenter;
    self.navDetailTitle.font = [UIFont systemFontOfSize:12.0f];
    self.navDetailTitle.textColor = [UIColor whiteColor];
    [self.navDetailTitle sizeToFit];
    self.navDetailTitle.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.navDetailTitle setCenter:CGPointMake(navTitleView.frame.size.width*0.5, 44)];
    
    [navTitleView addSubview:self.navTitle];
    [navTitleView addSubview:self.navDetailTitle];
    
    self.navigationItem.titleView = navTitleView;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updatePlayerTimeInfo
{
    _backgroundImage.image = s_backgroundImage;
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakself = self;
    dispatch_async(queue, ^{
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *image = [[CIImage alloc]initWithImage:[UIImage imageNamed:[MusicListManager sharedMusicListManager].currentPlayingMusicInfo.icon]];
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [filter setValue:image forKey:kCIInputImageKey];
        [filter setValue:@30.0f forKey:@"inputRadius"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef outImage = [context createCGImage:result fromRect:[image extent]];
        UIImage *blurImage = [UIImage imageWithCGImage:outImage];
        CGImageRelease(outImage);
        dispatch_sync(dispatch_get_main_queue(), ^{
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            [weakself.backgroundImage.layer addAnimation:transition forKey:@"a"];
            [weakself.backgroundImage setImage:blurImage];
            s_backgroundImage = blurImage;
        });
    });
    self.blackDisc.image = [Utils circleImage:[UIImage imageNamed:[MusicListManager sharedMusicListManager].currentPlayingMusicInfo.icon] withParam:56];
    self.navTitle.text = [[MusicListManager sharedMusicListManager] currentPlayingMusicInfo].name;
    self.navDetailTitle.text = [[MusicListManager sharedMusicListManager] currentPlayingMusicInfo].singer;
    
    self.currentTimeLabel.text = [Utils timeFormatWithTimeintervalToMinAndSec:[MusicListManager sharedMusicListManager].currentPlayingAudioPlayer.currentTime];
    self.durationTimeLabel.text = [Utils timeFormatWithTimeintervalToMinAndSec:[MusicListManager sharedMusicListManager].currentPlayingAudioPlayer.duration];
    self.musicPlayProgressSlider.maximumValue = [[MusicListManager sharedMusicListManager] currentPlayingAudioPlayer].duration;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)previousMusic:(id)sender
{
    [[MusicListManager sharedMusicListManager]playPreviousMusic];
    [self updatePlayerTimeInfo];
    if ([[MusicListManager sharedMusicListManager] currentPlayingAudioPlayer].isPlaying)
    {
        [self.discRotateLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    else
    {
        [self.discRotateLink invalidate];
        self.discRotateLink = nil;
    }
}

- (IBAction)nextMusic:(id)sender
{
    [[MusicListManager sharedMusicListManager]playNextMusic];
    [self updatePlayerTimeInfo];
    if ([[MusicListManager sharedMusicListManager] currentPlayingAudioPlayer].isPlaying)
    {
        [self.discRotateLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    else
    {
        [self.discRotateLink invalidate];
        self.discRotateLink = nil;
    }
}

- (IBAction)pauseOrPlay:(id)sender
{
    [[MusicListManager sharedMusicListManager] pauseOrPlayCurrentPlayingAudioPlayer];
    if ([[MusicListManager sharedMusicListManager] currentPlayingAudioPlayer].isPlaying)
    {
        [self.discRotateLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    else
    {
        [self.discRotateLink invalidate];
        self.discRotateLink = nil;
    }
}

- (IBAction)dragMusicPlayProgressSlider:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    self.currentTimeLabel.text = [Utils timeFormatWithTimeintervalToMinAndSec:slider.value];
}

-(IBAction)sliderTouchisBegin:(id)sender
{
    [self.link invalidate];
    self.link = nil;
}

-(IBAction)sliderTouchisEnd:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [[MusicListManager sharedMusicListManager] currentPlayingAudioPlayer].currentTime = slider.value;
}

@end
