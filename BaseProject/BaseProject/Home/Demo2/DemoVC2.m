//
//  DemoVC2.m
//  BaseProject
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/10/17.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "DemoVC2.h"

@interface DemoVC2 ()

@end

@implementation DemoVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用NSObject提供的方法创建子线程
//    [self performSelectorInBackground:@selector(readMe) withObject:nil];
//    [self performSelectorOnMainThread:@selector(readMe) withObject:nil waitUntilDone:YES];
    //方法回归主线程去执行
    //该方法主要用于 用主线程去修改页面的UI显示状态
    //此方法没有返回值
    //如果当前是主线程的时候， waitUntilDone:YES参数无效
    

    [self Sarial];
    
}

-(void)readMe{
    NSLog(@"readMe");
}

/** 执行串行队列操作 */
-(void)Sarial{
    //1、获取系统提供的串行队列(系统提供的串行队列，如果添加异步任务，任务会被同步来执行)

}


@end
