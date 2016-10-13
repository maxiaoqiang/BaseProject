//
//  DemoVC0.m
//  BaseProject
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/10/12.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "DemoVC0.h"

@interface DemoVC0 ()

@end

@implementation DemoVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     [self test1];
//     [self test2];
//       [self test3];
//    [self test4];
    
    [self test5];
}

/**
 GCD基础知识1
 如果是在子线程中调用 同步函数＋主队列，那么没有任何问题
 */

-(void)test1{
    /**
     1、什么是GCD？
     全称是Grand CentralDispatch,可译为“伟大的中枢调度器”，纯C语言，提供了非常多强大的函数
     2、GCD的优势
     GCD是苹果公司为多核的并行运算提出的解决方案
     GCD会自动利用更多的CPU内核（比如双核、四核）
     GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程），相比NSThrrad需要手动管理线程声明周期
     只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
     3、GCD中有2个核心概念：任务、队列
     任务：执行什么操作
     队列：用来存放任务
     队列的类型：并发队列 与 串行队列
     将任务添加到队列中，GCD会自动将队列中的任务取出，放到对应的线程中执行，任务的取出遵循队列的 FIFO原则：先进先出、后进后出
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    /**
     异步 dispatch_async:可以在新的线程中执行任务，具备开启新线程的能力
     dispatch_async(dispatch_queue_t  _Nonnull queue, <#^(void)block#>)
     另外一个执行任务的方法：dispatch_barrier_async(dispatch_queue_t  _Nonnull queue, ^{
     })
     场景：在前面的任务执行结束后它才执行、而且它后面的任务等它执行完成之后才会执行
     注意：这个queue不能是全局的并发队列
     
     */
    
    dispatch_async(queue, ^{
        /** block会在子线程中执行 */
        NSLog(@"线程1:%@",[NSThread currentThread]);
        /** 同步：dispatch_sync:只能在当前线程中执行任务，不具备开启新线程的能力 */
        /** 注意：使用sync函数往当前串行队列中添加任务，会卡在当前的串行队列 */
        dispatch_async(queue, ^{
           /** block一定会在主线程执行 */
            NSLog(@"线程2:%@",[NSThread currentThread]);
        });
    });
}

/** 
 GCD基础知识2
 如果是在主线程中调用 同步函数 ＋ 主队列，那么会导致死锁
 导致死锁的原因：
 sync函数是在主线程中执行，并且会等待block执行完毕，先调用
 block是添加到主队列，也需要在主线程中执行，后调用
 */
-(void)test2{
    if ([NSThread currentThread]) {
        NSLog(@"线程3:%@",[NSThread currentThread]);
    }
    
    /** 主队列 */
    dispatch_queue_t queue = dispatch_get_main_queue();
    /** 如果是调用同步函数，那么会等同步函数中的任务执行完毕，才会执行后面的代码 */
    /** 注意：如果dispatch_sync方法是在主线程中调用，并且传入的队列是主队列，那么会导致死锁 */
    
//    dispatch_sync(queue, ^{
//       
//        NSLog(@"线程4:%@",[NSThread currentThread]);
//    });
}

/** 
 GCD基础知识3
 异步 ＋ 主队列：不会创建新的线程，并且任务是在主线程中执行
 */

-(void)test3{
    /**
    主队列：只要将任务添加到主队列中，那么任务“一定”会在主线程中执行
     无论你是调用同步函数还是异步函数
     */
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"线程5:%@",[NSThread currentThread]);
    });
}


/** 
 GCD基础知识4
 同步 ＋ 并发：不会开启新的线程
 */

-(void)test4{
    /** 1、创建一个并发队列 */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    /** 2、将任务添加到队列中 */
    dispatch_sync(queue, ^{
        NSLog(@"任务1:%@",[NSThread currentThread]);
    });
    NSLog(@"线程6:%@",[NSThread currentThread]);
}

/** 
 基础知识5
 异步＋串行：会开启新的线程
 但是只会开启一个线程
 注意：如果调用 异步函数，那么不用等到函数中的任务执行完毕，就会执行后面的代码
 */

-(void)test5{
    /** 1、创建串行队列 */
    dispatch_queue_t queue = dispatch_queue_create("com.xq", DISPATCH_QUEUE_SERIAL);
    /** 
     能够创建新的线程的原因：
     我们是使用“异步”函数调用
     只创建1个子线程的原因：
     我们的队列是串行队列
     */
    /** 2、将任务添加到队列中 */
    dispatch_async(queue, ^{
        NSLog(@"任务1:%@",[NSThread currentThread]);
    });
    NSLog(@"线程7:%@",[NSThread currentThread]);
}

/** 
 GCD基础知识6
 异步 ＋ 并发：会开启新的线程
 如果任务比较多，那么就会开启多个线程
 */
-(void)test6{
    /** 
     执行任务
     dispatch_async 异步
     dispatch_sync 同步
     */
    /** 
     第一个参数：队列的名称
     第二个参数：告诉系统需要创建一个并发队列还是串行队列
     DISPATCH_QUEUE_CONCURRENT :串行
     DISPATCH_QUEUE_SERIAL  :并发
     
      dispatch_queue_t queue = dispatch_queue_create("com.xq", DISPATCH_QUEUE_SERIAL);
     系统内部已经给我们提供好了一个现成的并发队列
     */
    
    
    
}








@end
