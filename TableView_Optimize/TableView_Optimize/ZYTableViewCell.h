//
//  ZYTableViewCell.h
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTableViewCell : UITableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;

@property (nonatomic,   strong)     UIImageView * imageView1;

@property (nonatomic,   strong)     UIImageView * imageView2;

@end
