//
//  ViewController1.m
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/07.
//  Copyright © 2018 CSH. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"我是一级界面1";
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"参数-----%@",self.parameter);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [SHRoutingTool openUrlWithUrl:@"ViewController11" parameter:@{@"1":@"哈哈哈哈哈"} jumpType:SHJumpType_push block:^(NSDictionary *parameter) {
        
        NSLog(@"11 回调 -- %@",parameter);
    }];
}


@end
