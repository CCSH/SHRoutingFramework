//
//  ViewController21.m
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/07.
//  Copyright © 2018 CSH. All rights reserved.
//

#import "ViewController21.h"

@interface ViewController21 ()

@end

@implementation ViewController21

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我是一级界面2的子界面";
}

//- (BOOL)checkhParameter:(NSDictionary *)parameter{
//    return NO;
//}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"参数-----%@",self.parameter);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (self.block) {
        self.block(@{@"21":@"我去 view1 了"});
    }
    
    [SHRoutingTool openUrlWithUrl:@"ViewController1" parameter:@{@"21":@"哈哈哈哈哈"} jumpType:SHJumpType_pop_root block:^(NSDictionary *parameter) {
        
        NSLog(@"21 回调 -- %@",parameter);
    }];
    
}

@end
