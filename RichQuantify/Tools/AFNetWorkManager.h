//
//  AFNetWorkManager.h
//  长联
//
//  Created by 岳万里 on 16/11/8.
//  Copyright © 2016年 岳万里. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetWorkManager : NSObject
+(AFHTTPSessionManager *)sharedHttpSessionManager;
@end
