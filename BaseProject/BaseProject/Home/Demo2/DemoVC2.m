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
    //1、获取系统提供的串行队列(系统提供的串行队列，如果添加异步任务，任务会被同步来执行,并且在主线程中执行)
    dispatch_queue_t queue1 = dispatch_get_main_queue();//获取主队列，往里面添加的任务都是由主线程完成的(所以会按照执行顺序一个一个的来)
    //2、定义串行队列参数(参数1:队列的唯一标示，命名使用反域名，参数2:队列的类型(串行或者并行)，向自定义的串行队列中添加异步执行的任务，任务还是会同步执行，只不过不在主线程执行了(所以不会造成了太大的卡顿))
    dispatch_queue_t queue2 = dispatch_queue_create("xq", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("xq", NULL);
    //向串行队列中添加并发(异步任务)
    //一般在使用串行的时候，多采用自定义的串行队列，因为队列中如果执行任务会交给子线程去处理，不会造成太大的界面卡顿现象
    //任务组:可以将多个任务放到任务组这样做的好处是当任务组的所有任务完成的时候，可以通过一个方法告知我们
    //创建一个任务组
    dispatch_group_t group = dispatch_group_create();
    //创建一个队列
    //创建任务组任务
    dispatch_group_async(group, queue2, ^{
        NSLog(@"第一个任务组1");
    });
    //监听任务组中所有任务是否完成的方法
    dispatch_group_notify(group, queue2, ^{
        NSLog(@"监听的任务都完成了");
    });
    
}

/** 只执行一次 */
-(void)Once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只允许一次");
    });
}

/** 在一个队列中重复执行一个任务n次 */
-(void)repeat{
    
    dispatch_queue_t queue = dispatch_queue_create("xq", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, queue, ^(size_t index) {
           /** 
            1、执行线程下标%zu
            2、参数1:代表重复执行的次数
            3、参数2:代表任务添加到的队列
            4、参数3:代表执行任务的下标，从0开始
            */
        
    });
    
}

//延迟执行
-(void)delay{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"晚点");
    });
}





@end
