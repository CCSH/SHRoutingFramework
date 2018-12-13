//
//  ViewController2.m
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/07.
//  Copyright © 2018 CSH. All rights reserved.
//

#import "ViewController2.h"


@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.parameter[@"1"];

    self.title = @"我是一级界面2";
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"参数-----%@",self.parameter);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
