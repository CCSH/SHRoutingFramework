//
//  SHBaseHttp.m
//  iOSAPP
//
//  Created by CSH on 16/7/5.
//  Copyright © 2016年 CSH. All rights reserved.
//

#import "SHBaseHttp.h"
#import "AFNetworking.h"

#define TimeOut 30

@implementation SHBaseHttp

//请求队列
static NSMutableArray <NSURLSessionDataTask *>*operationQueueArr;

#pragma mark - 实例化请求对象
+ (AFHTTPSessionManager *)getAFHTTPSessionManager{
    
    static AFHTTPSessionManager *mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 1.获得请求管理者
        mgr = [AFHTTPSessionManager manager];
        // 2.添加参数
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        // 3.支持HTTPS
        mgr.securityPolicy.allowInvalidCertificates = YES;
        mgr.securityPolicy.validatesDomainName = NO;
        
        operationQueueArr = [[NSMutableArray alloc]init];
        
        mgr.requestSerializer.timeoutInterval = TimeOut;
    });

    return mgr;
}

#pragma mark - GET
+ (void)getWithRetryNum:(NSInteger)retryNum url:(NSString *)url param:(NSDictionary *)param progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 发送GET请求
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AFHTTPSessionManager *mgr = [SHBaseHttp getAFHTTPSessionManager];
        
        NSURLSessionDataTask *task = [mgr GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //移除队列
            [operationQueueArr removeObject:task];
            
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //移除队列
            [operationQueueArr removeObject:task];
            
            if (retryNum > 0) {
                //重新请求
                [self getWithRetryNum:retryNum-1 url:url param:param progress:progress success:success failure:failure];
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }];
        //添加队列
        [operationQueueArr addObject:task];
    });
}

#pragma mark - POST
+ (void)postWithRetryNum:(NSInteger)retryNum url:(NSString *)url param:(NSDictionary *)param progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    // 发送POST请求
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AFHTTPSessionManager *mgr = [SHBaseHttp getAFHTTPSessionManager];
        
        NSURLSessionDataTask *task = [mgr POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //移除队列
            [operationQueueArr removeObject:task];
            
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //移除队列
            [operationQueueArr removeObject:task];
            
            if (retryNum > 0) {
                //重新请求
                [self postWithRetryNum:retryNum-1 url:url param:param progress:progress success:success failure:failure];
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }];
        //添加队列
        [operationQueueArr addObject:task];
    });
}

#pragma mark - 文件上传
+ (void)postUploadFileWithRetryNum:(NSInteger)retryNum url:(NSString *)url param:(NSDictionary *)param fileType:(NSString *)fileType File:(NSString *)file progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    // 发送文件上传
    NSURLSessionDataTask *task = [[SHBaseHttp getAFHTTPSessionManager] POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:file];
        if (data) {
             [formData appendPartWithFileData:data name:@"file" fileName:file.lastPathComponent mimeType:fileType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //移除队列
        [operationQueueArr removeObject:task];
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //移除队列
        [operationQueueArr removeObject:task];
        
        if (retryNum > 0) {
            //重新请求
            [self postUploadFileWithRetryNum:retryNum-1 url:url param:param fileType:fileType File:file progress:progress success:success failure:failure];
        }else{
            if (failure) {
                failure(error);
            }
        }
    }];
    //添加队列
    [operationQueueArr addObject:task];
}

#pragma mark - 文件下载
+ (void)downLoadFlieWithRetryNum:(NSInteger)retryNum url:(NSString *)url flie:(NSString *)file progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    //1.创建会话管理者
    NSURL *fileUrl = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    
    //2.下载文件
    NSURLSessionDownloadTask *task = [[SHBaseHttp getAFHTTPSessionManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:file];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            if (retryNum > 0) {
                NSInteger num = retryNum;
                //重新请求
                [self downLoadFlieWithRetryNum:--num url:url flie:file progress:progress success:success failure:failure];
            }else{
                if (failure) {
                    failure(error);
                }
            }
        }else{
            if (success) {
                success([filePath path]);
            }
        }
    }];
    
    //3.执行Task
    [task resume];
}

#pragma mark - 取消所有网络请求
+ (void)cancelAllOperations{
    
    for (int i = 0; i < operationQueueArr.count; i++) {
        
        NSURLSessionDataTask *task = operationQueueArr[0];
        //取消请求
        [task cancel];
        //移除队列
        [operationQueueArr removeObject:task];
    }
}

@end
