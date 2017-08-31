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
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0, _cellSize.height, _cellSize.height)];
        
        [self setValue:imageView forKey:@"imageView"];  // readOnly property , KVC
    }
    return self;
}


@end
