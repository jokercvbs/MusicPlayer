//
//  MusicsViewController.m
//  02-音乐播放器
//
//  Created by 林信成 on 16/6/14.
//  Copyright © 2016年 林信成. All rights reserved.
//


#import "MusicsViewController.h"
#import "MJMusic.h"
#import "MJExtension.h"
#import "AudioTool.h"
#import "MusicCell.h"
#import "MusicPlayerController.h"
#import "MusicListManager.h"
#import "Utils.h"

@interface MusicsViewController ()

@end


@implementation MusicsViewController

#pragma mark - view controller life events
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayIsPlayingMusic)
                                                 name:k_refreshPlayingMusicList
                                               object:nil];
}

-(void)displayIsPlayingMusic
{
    int lastIndex = [MusicListManager sharedMusicListManager].lastPlayingMusicIndex;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastIndex inSection:0];
    
    int currentIndex = [MusicListManager sharedMusicListManager].isPlayingMusicIndex;
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    
    MusicCell *lastCell = (MusicCell *)[self.tableView cellForRowAtIndexPath:lastIndexPath];
    lastCell.music = [MusicListManager sharedMusicListManager].musicList[lastIndexPath.row];
    
    MusicCell *currentCell = (MusicCell *)[self.tableView cellForRowAtIndexPath:currentIndexPath];
    currentCell.music = [MusicListManager sharedMusicListManager].musicList[currentIndexPath.row];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MusicListManager sharedMusicListManager].musicList.count;
}

- (MusicCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell *cell = [MusicCell cellWithTableView:tableView];
    cell.music = [MusicListManager sharedMusicListManager].musicList[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[MusicListManager sharedMusicListManager] playMusicWithIndex:(int)indexPath.row];
    [self displayIsPlayingMusic];
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    MusicPlayerController *musicPlayerController=[board instantiateViewControllerWithIdentifier:@"MusicPlayerController"];
    [self.navigationController pushViewController:musicPlayerController animated:YES];
}

@end
