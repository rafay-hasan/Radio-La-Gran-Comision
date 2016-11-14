//
//  ViewController.m
//  RADIO LA GRAN COMISIÓN
//
//  Created by Rafay Hasan on 11/10/16.
//  Copyright © 2016 Rafay Hasan. All rights reserved.
//

#import "ViewController.h"
#import "StreamingFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(showShongData) userInfo:nil repeats:YES];
    
    //[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(songChanged:) name:<#(nullable NSNotificationName)#> object:<#(nullable id)#>
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerAction:) name:@"SongNotification" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) triggerAction:(NSNotification *) notification
{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"song name is %@",[dict valueForKey:@"songName"]);
}


@end
