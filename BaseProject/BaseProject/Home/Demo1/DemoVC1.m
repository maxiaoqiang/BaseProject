//
//  DemoVC1.m
//  BaseProject
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/10/12.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "DemoVC1.h"

@interface DemoVC1 ()

@end

@implementation DemoVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 
     程序：代码生成的可执行的应用程序
     进程：运行起来的程序（相当于运行的过程）
     线程：程序中独立运行的代码段（有很多功能代码段，一步一步来执行）
     一个程序中只有一个进程（不可能同时运行两遍），一个进程由多个线程组成（至少一个线程），进程申请资源和分配资源给线程用，线程使用资源（相当于执行代码）
     如果一个进程里面只有一个线程，即主线程，主线程在程序运行的时候被创建，用于执行main函数里面的代码，在只有一个主线程的情况下，主线程负责所有代码的执行，包括UI界面的更新、网络请求、本地存储等、这些线程都是顺序执行的，不能一并执行
     我们可以开辟多个新的线程、这些线程都是主线程的子线程、（主线程主要负责UI界面各种控件的显示）
     注意：主线程和子线程都是相互独立的去执行代码、互不影响，并发执行（可以同时执行）
     注意：UI更新，必须放在主线程中去更新（也就是各种控件的显示情况），因为开辟子线程，是不受控制的，什么时候执行结束我们无法控制，所以，在子线程中去更新UI界面会出现的bug是无法预料的
     简单来说，就是我们所学的控件都相当于一个一个的容器、用来盛放数据、必须先把容器准备好、（显示完毕）才能往里面放数据、而主线程是最快被执行的，UI更新都放在主线程
     
     */
    
    [self setup];
}

/** 请求图片 */
-(void)imageDownLoader{
    NSLog(@"开始下载图片");
}
/** 计算方法 */
-(void)calculate{
    NSLog(@"开始计算");
}


-(void)setup{
    //NSthread开辟子线程
    //分为两种方式，一种是需要手动启动线程，另一种是自动开启
    //手动开启子线程
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(calculate) object:nil];
//    [thread start];//手动启动线程
//    [thread cancel];//手动关闭线程
    
    //第二种方式：自动开启线程执行
//    [NSThread detachNewThreadSelector:@selector(calculate) toTarget:self withObject:nil];
//    [self imageDownLoader];
    //不要在子线程中使用异步请求(异步请求本身就相当于开辟了子线程)
    //NSThread相当于接下来要讲的NSOperationQueue和GCD是一个轻量级的多线程
    //第一种创建方式，需要手动开启，关闭
    //第一个参数:谁来执行这个方法(由本类对象执行，减号方法)
    //第二个参数:要被执行的方法，这个方法在子线程中去执行(一般都是网络请求)
    //第三个参数:被执行的方法如果带有参数，可以放在这个位置进行传递
    //注意:子线程中如果使用了便利构造器是需要我们自己去创建释放池，因为程序在运行的时候主线程走main函数，main里面带有一个释放池
    //============== 线程队列 ========
    //NSOperation这个队列虽然牛，但是我们都是使用其子类
    //1、创建任务
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(calculate) object:nil];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self imageDownLoader];
    }];
    //重点来了，创建要执行的任务都是由以上两个类来创建，那接下来创建队列要是有抽象类NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //如何设置同步执行呢(串行)
    //1、设置任务之间的依赖关系
    //建立关系必须放在添加任务之前
    [operation1 addDependency:operation2];
    //添加任务
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    //设置队列的最大并行个数Concurrent并行
    [queue setMaxConcurrentOperationCount:1];
    
    //在队列里面的任务的执行是并发执行，多个任务由多个线程执行，但是线程的分配由队列完成，线程与线程之间相互不会影响，因此我们最终无法判断哪个任务会先被执行完毕
    //线程并发：多个任务分配时，遵循FIFO(先来先服务)的原则，但是多个任务执行的时候是同时执行的，有可能最晚分配的任务最先被执行
    //队列帮助我们管理线程的分配，队列中任务的个数大于等于线程的个数
    //在队列中的串行与单线程处理任务的原理很像，所以在任务开发中以并行情况居多
    
}




@end
