//
//  MusicCell.h
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/15.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJMusic;
@interface MusicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UILabel *musicLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicDetailLabel;
@property(nonatomic, retain)MJMusic *music;
+(instancetype)cellWithTableView:(UITableView*)tableView;
-(void)setMusic:(MJMusic *)music;
@end
