//
//  Utils.h
//  02-音乐播放器
//
//  Created by 林信成 on 16/8/1.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
static NSString *k_refreshPlayingMusicList = @"refreshPlayingMusicList";
@interface Utils : NSObject
+(NSString*)timeFormatWithTimeintervalToMinAndSec:(NSTimeInterval)timeInterval;
+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;
@end
