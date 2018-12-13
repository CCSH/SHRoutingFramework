//
//  SHRoutingTool.m
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/7.
//  Copyright © 2018 CSH. All rights reserved.
//

#import "SHRoutingTool.h"
#import <UIKit/UIKit.h>
#import "SHViewController.h"

@implementation SHRoutingTool

#pragma mark 打开界面
+ (void)openUrlWithUrl:(NSString *)url parameter:(NSDictionary *)parameter jumpType:(SHJumpType)jumpType block:(nonnull Block)block{
    
    //获取类名
    NSString *calssName = [SHRoutingTool getClassNameWithUrl:url];
    
    //界面拦截
    if (![SHRoutingTool interfaceInterceptWithName:calssName]) {
        //进入登录界面
        return;
    }
    
    //目标控制器
    SHViewController *targetVC = [[NSClassFromString(calssName) alloc]init];
    //参数检查
    if (![targetVC checkhParameter:parameter]) {
        //参数错误
        return ;
    }

    //参数
    if (parameter) {
        targetVC.parameter = parameter;
    }
    //回调
    if (block) {
        targetVC.block = block;
    }
    
    //当前控制器
    UIViewController *currentVC = [SHRoutingTool getCurrentVC];
    
    switch (jumpType) {
        case SHJumpType_push:
        {
            [currentVC.navigationController pushViewController:targetVC animated:YES];
            return ;
        }
            break;
        case SHJumpType_model:
        {
            [currentVC presentViewController:targetVC animated:YES completion:nil];
            return ;
        }
            break;
        case SHJumpType_pop:
        {
            if (currentVC.navigationController) {
                [currentVC.navigationController popViewControllerAnimated:YES];
            }else{
                [currentVC dismissViewControllerAnimated:YES completion:nil];
            }
            return ;
        }
            break;
        case SHJumpType_pop_root:
        {
            [currentVC.navigationController popToRootViewControllerAnimated:YES];
            return ;
        }
            break;
        case SHJumpType_specify:
        {
            //就在当前页面
            SHViewController *vc = [currentVC.navigationController.viewControllers lastObject];
            if ([vc isKindOfClass:[NSClassFromString(calssName) class]]) {
                //参数
                if (parameter) {
                    vc.parameter = parameter;
                }
                //回调
                if (block) {
                    targetVC.block = block;
                }
                return ;
            }
            
            //栈里面存在
            for (SHViewController *obj in currentVC.navigationController.viewControllers) {
                
                if ([obj isKindOfClass:[NSClassFromString(calssName) class]]) {
                    if (parameter) {
                        vc.parameter = parameter;
                    }
                    //回调
                    if (block) {
                        targetVC.block = block;
                    }
                    [currentVC.navigationController popToViewController:obj animated:YES];
                    return ;
                    break;
                }
            }
            
            //不存在则正常跳转
            [self openUrlWithUrl:url parameter:parameter jumpType:SHJumpType_push block:block];
        }
            break;
        default:
            break;
    }
}

#pragma mark 获取参数
+ (NSDictionary *)getParameterWithUrl:(NSString *)url{
    
    //解析参数
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSArray *arr = [[NSURL URLWithString:url].query componentsSeparatedByString:@"&"];
    
    for (NSString *obj in arr) {
        
        NSArray *temp = [obj componentsSeparatedByString:@"="];
        [dic setObject:temp[1] forKey:temp[0]];
    }
    
    return dic;
}

#pragma mark 获取当前控制器
+ (UIViewController *)getCurrentVC{
    
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

#pragma mark 获取类名
+ (NSString *)getClassNameWithUrl:(NSString *)url{
    
    //通过路由配置信息获取控制器名字
    
    return url;
}

#pragma mark 界面拦截
+ (BOOL)interfaceInterceptWithName:(NSString *)name{
    //通过路由配置信息获取是否需要拦截
    
    //例如：需要登录，但是没有登录 返回 NO
    
    
    return YES;
}

@end
