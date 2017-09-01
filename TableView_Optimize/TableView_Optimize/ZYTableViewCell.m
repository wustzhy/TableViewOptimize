//
//  ZYTableViewCell.m
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYTableViewCell()

@end

@implementation ZYTableViewCell
{
    CGSize _cellSize;
    
}

#pragma mark - life
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        _cellSize = cellSize;
        
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 30)];
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:15];
        lb.textColor = [UIColor blueColor];
        lb.textAlignment = NSTextAlignmentLeft;
        [self setValue:lb forKey:@"textLabel"];
        
        
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, _cellSize.height, _cellSize.height)];
        [self.contentView addSubview:self.imageView1];
        [self.contentView bringSubviewToFront:self.imageView1];
        
        self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 0, _cellSize.height, _cellSize.height)];
        [self.contentView addSubview:self.imageView2];
        [self.contentView bringSubviewToFront:self.imageView2];
    }
    return self;
}


@end
