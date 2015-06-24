//
//  ViewController.m
//  TTSDemo
//
//  Created by hugo on 15-6-24.
//  Copyright (c) 2015年 hugo. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property(nonatomic,retain)UITextField *textField;

@end

#define ScreenSize [UIScreen mainScreen].bounds.size

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self buildTextFieldUI];
    
    [self playUI];
}

-(void)buildTextFieldUI
{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, ScreenSize.width - 20*2,44)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"文字转语音";
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_textField];
}

-(void)playUI
{
    UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
    [play setTitle:@"play" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [play setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [play setFrame:CGRectMake(20, _textField.frame.size.height +_textField.frame.origin.y+50, ScreenSize.width - 20*2, 44)];
    [play addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
}

-(void)play
{
    if (_textField.text.length>0) {
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-TW"];
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:_textField.text];
        utterance.voice = voice;
        utterance.rate = 0.1;
        utterance.volume = 1.0;
        AVSpeechSynthesizer *syntheSizer = [[AVSpeechSynthesizer alloc]init];
        syntheSizer.delegate = self;
        [syntheSizer speakUtterance:utterance];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入文字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark- avSpeechSynthesizerDelegate

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
  [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
