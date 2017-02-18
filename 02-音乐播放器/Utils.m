//
//  Utils.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/8/1.
//  Copyright © 2016年 林信成. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString*)timeFormatWithTimeintervalToMinAndSec:(NSTimeInterval)timeInterval
{
    unsigned int unitFlags =  NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1 toDate:date2 options:0];
    return [NSString stringWithFormat:@"%02ld:%02ld",(long)[conversionInfo minute],(long)[conversionInfo second]];
}

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset
{
    UIImage *blackDisc = [UIImage imageNamed:@"cm2_play_disc"];
    
    CGSize size= CGSizeMake (blackDisc.size.width, blackDisc. size.height); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions (size, NO, 0.0);
    
    [blackDisc drawAtPoint:CGPointMake (0,0)];
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    
    CGRect rect = CGRectMake(inset, inset, blackDisc.size.width - inset *2.0f, blackDisc.size.height - inset *2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}
@end
