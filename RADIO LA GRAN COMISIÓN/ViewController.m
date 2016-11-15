//
//  ViewController.m
//  RADIO LA GRAN COMISIÓN
//
//  Created by Rafay Hasan on 11/10/16.
//  Copyright © 2016 Rafay Hasan. All rights reserved.
//

#import "ViewController.h"
#import "StreamingFile.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger imageCounter;
}



@property (weak, nonatomic) IBOutlet UIButton *radioButton;

@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
- (IBAction)galleryAction:(id)sender;

- (IBAction)worldIconAction:(id)sender;

- (IBAction)facebookAction:(id)sender;
- (IBAction)twitterAction:(id)sender;

- (IBAction)buyMusicAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *homeBgImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    imageCounter = 0;
    
    NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
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
    //NSLog(@"song name is %@",[dict valueForKey:@"songName"]);
    
    self.songNameLabel.text = [dict valueForKey:@"songName"];
}


- (IBAction)playPauseButtonAction:(UIButton *)sender {
    
    if([[self.radioButton backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"play"]])
    {
        [[StreamingFile sharedInstance] pausePlayer];
        [self.radioButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    else
    {
        [[StreamingFile sharedInstance] playPlayer];
        [self.radioButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    

}


- (IBAction)galleryAction:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];}


- (IBAction)worldIconAction:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://radiolagrancomisiontv.org"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];

}

- (IBAction)facebookAction:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"https://www.facebook.com/lagrancomisionradio/"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];

}

- (IBAction)twitterAction:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://twitter.com/RLaGranComision"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (IBAction)buyMusicAction:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://tunein.com/radio/Radio-La-Gran-Comision-s207440/"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

-(void) changeImage
{
    imageCounter = imageCounter + 1;
    self.homeBgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%li",(long)imageCounter]];
    
    if(imageCounter == 4)
        imageCounter = 0;
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     [picker dismissViewControllerAnimated:YES completion:nil];}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
