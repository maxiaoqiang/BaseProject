//
//  DemoVC3.m
//  BaseProject
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/11/1.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "DemoVC3.h"

@interface DemoVC3 ()

@end

@implementation DemoVC3
/** 
 地图:提供地图展示和地图操作功能
 室内图:提供展示公众建筑物室内地图的展示功能
 POI检索:支持周边检索、区域检索和城市内兴趣点检索
 室内POI检索:支持设置城市和当前建筑物的室内POI检索
 地理编码:提供经纬度和地址信息相互转换的功能接口
 线路规划:支持公交、驾车、步行、骑行，四种方式的线路规划
 覆盖物图层:支持在地图上添加覆盖物(标注、几何图形、热力图、地形图图层)，展示更丰富的LBS信息
 定位:获取当前位置信息，并在地图上展示(支持普通、跟随、罗盘三种模式)
 离线地图:使用离线地图可节省用户流量，提供更好的地图展示效果
 调起百度地图:利用SDK接口，直接在本地打开百度地图客户端或WebApp，实现地图功能
 周边雷达:利用周边雷达功能，开发者可在App内低成本，快速实现查找周边使用相同App的用户位置的功能
 LBS云检测:支持在地图上添加自有瓦片数据
 特色功能:提供短串分享、Place详情检索、热力图等特色功能，帮助开发者搭建功能更加强大的应用
 兼容性:百度地图iOS SDK支持iOS 5.0及以上操作系统，支持armv7、armv7s、armv64
 管理地图的生命周期:自2.0.0起,BMKMapView新增viewWillAppear,viewWillDisappear方法来控制BMKMapView的生命周期,并且在一个时刻只能有一个BMKMapView接受回调消息，因此在使用BMKMapView的ViewController中需要在ViewWillAppear、ViewWillDiappear方法中调用BMKMapView的对应的方法，并且处理delegate
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    

}



@end
