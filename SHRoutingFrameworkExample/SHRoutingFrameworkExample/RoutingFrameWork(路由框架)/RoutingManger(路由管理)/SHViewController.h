//
//  SHViewController.h
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/07.
//  Copyright © 2018 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHRoutingTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHViewController : UIViewController

//参数
@property (nonatomic, copy) NSDictionary *parameter;

//回调
@property (nonatomic, copy) Block block;

#pragma mark 参数检查
- (BOOL)checkhParameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
