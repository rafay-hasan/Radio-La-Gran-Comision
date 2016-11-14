//
//  StreamingFile.m
//  Radio
//
//  Created by Muhammod Rafay on 7/6/16.
//  Copyright (c) 2016 Rafay. All rights reserved.
//

#import "StreamingFile.h"

@implementation StreamingFile

+ (StreamingFile *)sharedInstance {
    
    static dispatch_once_t pred;
    static StreamingFile *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    
    return sharedInstance;
}


- (id)init{
    self = [super init];
    
    return self;
}

-(void) makeStreamingWithUrl:(NSString *)streamingUrlString
{
    /*
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&sessionError];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    self.asset = [AVAsset assetWithURL:[NSURL URLWithString:streamingUrlString]];
    NSArray *assetKeys = @[@"playable", @"hasProtectedContent"];
    self.item = [AVPlayerItem playerItemWithAsset:self.asset];
    
    [self setPlayer:[[AVPlayer alloc] initWithPlayerItem:self.item]];
    
    [[self player] setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    
    [[self player] play];
    
    NSLog(@"items are %@",self.item.asset.commonMetadata);
    
    if(sessionError)
        NSLog(@"error is %@",[sessionError localizedDescription]);
     
     */
    
    self.item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:streamingUrlString]];
    
    [self.item addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:self.item];
    [self.player play];

}


-(void) pausePlayer
{
    //self.lastState = @"pause";
    [[self player]pause];
}

-(void) playPlayer
{
    //self.lastState = @"play";
    [[self player] play];
}


-(void) setVoluneOfPlayer: (float) value
{
    [[self player]setVolume:value];
}

-(void) getSongInfo
{
    //NSString *metadata = [self.player.currentItem.asset lyrics];
    //NSLog(@"items are %@",self.item.asset.commonMetadata);
//    for(AVMetadataItem *item in metadata)
//    {
//        NSLog(@"items are %@",item);
//        if([item.commonKey isEqualToString:@"artwork"])
//        {
//            
//        }
//    }
    
    
    NSArray *metadataList = [self.item.asset commonMetadata];
    NSLog(@"list is %@",metadataList);
    for (AVMetadataItem *metaItem in metadataList) {
        NSLog(@"%@",metaItem.value);
    }
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object
                         change:(NSDictionary*)change context:(void*)context {
    
    if ([keyPath isEqualToString:@"timedMetadata"])
    {
        AVPlayerItem* playerItem = object;
        
        //NSLog(@"%@",playerItem.timedMetadata);
        
        for (AVMetadataItem* metadata in playerItem.timedMetadata)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:metadata.stringValue,@"songName", nil];
            
            
            //NSLog(@"title is %@", metadata.stringValue);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SongNotification" object:nil userInfo:dic];
            break;
        }
    }
}


@end
