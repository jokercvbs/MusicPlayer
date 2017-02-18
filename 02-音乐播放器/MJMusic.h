//
//  MJMusic.h
//  预习-03-音乐播放器
//
//  Created by MJ Lee on 14-6-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJMusic : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *filename;
@property (copy, nonatomic) NSString *singer;
@property (copy, nonatomic) NSString *singerIcon;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic, getter=isPlaying)BOOL playing;
@end
