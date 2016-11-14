//
//  StreamingFile.h
//  Radio
//
//  Created by Muhammod Rafay on 7/6/16.
//  Copyright (c) 2016 Rafay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MPVolumeView.h>


@interface StreamingFile : NSObject


@property (strong,nonatomic) AVPlayer *player;
@property (strong,nonatomic) AVPlayerItem *item;
@property (strong,nonatomic) AVAsset *asset;

-(void) makeStreamingWithUrl:(NSString *)streamingUrlString;
-(void) pausePlayer;
-(void) playPlayer;
-(void) setVoluneOfPlayer: (float) value;
-(void) getSongInfo;

+ (StreamingFile *)sharedInstance;

@end
