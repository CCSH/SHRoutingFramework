//
//  ViewController11.m
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/07.
//  Copyright © 2018 CSH. All rights reserved.
//

#import "ViewController11.h"

@interface ViewController11 ()

@end

@implementation ViewController11

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我是一级界面1的子界面";
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"参数-----%@",self.parameter);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.block) {
        self.block(@{@"11":@"我去 view21 了"});
    }
    
    [SHRoutingTool openUrlWithUrl:@"ViewController21" parameter:@{@"21":@"哈哈哈哈哈"} jumpType:SHJumpType_push block:^(NSDictionary *parameter) {
        
        NSLog(@"21 回调 -- %@",parameter);
    }];
}


@end
