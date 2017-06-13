//
//  KeyboardViewController.m
//  CustomKeyboardExtension
//
//  Created by DONLINKS on 16/7/25.
//  Copyright © 2016年 Donlinks. All rights reserved.
//

#import "KeyboardViewController.h"


@interface KeyboardViewController ()
@end

@implementation KeyboardViewController
{
    UIView *keyBoardView;
}
- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    keyBoardView = [[UINib nibWithNibName:@"Keyboard" bundle: nil] instantiateWithOwner:nil options:nil][0];
    keyBoardView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220);
    for(UIView *btn in [keyBoardView subviews]){
        if([btn isKindOfClass: [UIButton class]]){
            btn.layer.cornerRadius = btn.frame.size.height/2;
        }
    }
    [self.view addSubview: keyBoardView];
    
    for(UIButton *btn in [keyBoardView subviews]){
        if([btn isKindOfClass: [UIButton class]]){
            [btn addTarget:self action:@selector(keyDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

-(void)keyDidClick:(UIButton *)btn {
    switch (btn.tag) {
        case 116:
            [self advanceToNextInputMode]; //切换输入法
            break;
        case 115:
            [self dismissKeyboard];//键盘隐藏
            break;
        case 119:{
            [self.textDocumentProxy deleteBackward];//删除上个输入
        }
            break;
        case 120:{
            [self.textDocumentProxy insertText: @"\n"]; //按下发送键，即 returnKey
        }
            break;
            
        default:
        {
            [self.textDocumentProxy insertText: [btn titleForState: UIControlStateNormal]]; //插入文本
            if(btn.tag == 114){
                //TODO: 计算
                
            }
        }
            break;
    }
}

- (void)textWillChange:(id<UITextInput>)textInput {
    
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    
}

@end

