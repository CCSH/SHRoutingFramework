//
//  SHBaseHttp.h
//  iOSAPP
//
//  Created by CSH on 16/7/5.
//  Copyright © 2016年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络基础POST、GET
 */

@interface SHBaseHttp : NSObject

/**
 GET请求

 @param retryNum 重试次数
 @param url 网址
 @param param 参数
 @param progress 进度
 @param success 成功
 @param failure 失败
 */
+ (void)getWithRetryNum:(NSInteger)retryNum url:(NSString *)url param:(NSDictionary *) param progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 POST请求

 @param retryNum 重试次数
 @param url 网址
 @param param 参数
 @param progress 进度
 @param success 成功
 @param failure 失败
 */
+ (void)postWithRetryNum:(NSInteger)retryNum url:(NSString *)url param:(NSDictionary *)param progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 POST文件上传

 @param retryNum 重试次数
 @param url 网址
 @param param 参数
 @param fileType 文件类型
 @param file 文件路径
 @param progress 进度
 @param success 成功
 @param failure 失败
 */
+ (void)postUploadFileWithRetryNum:(NSInteger)retryNum url:(NSString *)url param:(NSDictionary *)param fileType:(NSString *)fileType File:(NSString *)file progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 文件下载

 @param retryNum 重试次数
 @param url 网址
 @param file 文件下载路径
 @param progress 进度
 @param success 成功
 @param failure 失败
 */
+ (void)downLoadFlieWithRetryNum:(NSInteger)retryNum url:(NSString *)url flie:(NSString *)file progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//取消所有网络请求
+ (void)cancelAllOperations;

@end
