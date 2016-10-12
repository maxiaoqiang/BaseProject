//
//  BaseHomeCell.m
//  BaseProject
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/10/12.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "BaseHomeCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation BaseHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        ;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 20)];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kWidth - 20, 20)];
        [self.contentView addSubview:self.contentLabel];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
