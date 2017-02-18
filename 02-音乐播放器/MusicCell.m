//
//  MusicCell.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/15.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import "MusicCell.h"
#import "MJMusic.h"
#import "UIImage+MJ.h"

@interface MusicCell()
@property(nonatomic, strong)CADisplayLink *link;
@end
@implementation MusicCell

-(CADisplayLink *)link
{
    if(!_link)
    {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *ID = @"musicListCell";
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        MusicCell *musicCell = [[MusicCell alloc] init];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MusicCell" owner:musicCell options:nil];
        cell = (MusicCell *)[nib objectAtIndex:0];
    }
    return cell;
}

-(void)setMusic:(MJMusic *)music
{
    _music = music;
    self.musicLabel.text = music.name;
    self.musicDetailLabel.text = music.singer;
    self.musicImage.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2 borderColor:[UIColor purpleColor]];
    if(music.isPlaying)
    {
            [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    else
    {
        [self.link invalidate];
        self.link = nil;
        self.musicImage.transform = CGAffineTransformIdentity;
    }
}

-(void)update
{
    // 1/60秒 * 45
    // 规定时间内转动的角度 == 时间 * 速度
    CGFloat angle = self.link.duration * M_PI_4;
    self.musicImage.layer.transform = CATransform3DRotate(self.musicImage.layer.transform, angle, 0, 0, 1);
    
}
@end
