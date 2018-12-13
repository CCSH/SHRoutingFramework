//
//  IUserServer.m
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/7.
//  Copyright © 2018 CSH. All rights reserved.
//

#import "IUserServer.h"
#import "SeverHeader.h"
#import "SHBaseHttp.h"

@implementation IUserServer

#pragma mark 登录接口
+ (void)getLoginWithTelNo:(NSString *)telNo passWord:(NSString *)passWord result:(netWorkBlock)result{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kMainUrl,kLoginUrl];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    if (telNo) {
        [parameter setObject:telNo forKey:@"telNo"];
    }
    if (passWord) {
        [parameter setObject:passWord forKey:@"passWord"];
    }
    
    [SHBaseHttp getWithRetryNum:2 url:url param:parameter progress:nil success:^(id responseObj) {

        IServerBaseModel *model = [[IServerBaseModel alloc]init];
        if (result) {
            result(model,nil);
        }
        
    } failure:^(NSError *error) {
        if (result) {
            result(nil,error);
        }
    }];
    
}

@end
