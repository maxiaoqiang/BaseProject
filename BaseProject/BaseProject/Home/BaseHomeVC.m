//
//  BaseHomeVC.m
//  BaseProject
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/10/12.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "BaseHomeVC.h"
#import "BaseHomeCell.h"

@interface BaseHomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_contentArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

NSString *const demo0Description = @"GCD（一）";
NSString *const demo1Description = @"GCD（二）";
NSString *const demo2Description = @"333";


@implementation BaseHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    _contentArray = @[demo0Description,demo1Description,demo2Description];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CELL";
    BaseHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BaseHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"demo---%ld",indexPath.row];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",_contentArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *demoClassString = [NSString stringWithFormat:@"DemoVC%ld",indexPath.row];
    UIViewController *vc = [NSClassFromString(demoClassString) new];
    vc.title = demoClassString;
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
