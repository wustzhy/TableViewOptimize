//
//  ZYTableView.m
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import "ZYTableView.h"

#import "ZYTableViewCell.h"

#import "ZYTool.h"  // 设圆角

@interface ZYTableView()<UITableViewDelegate , UITableViewDataSource>

@end

@implementation ZYTableView
{
    CGFloat _cellHeight;
    
}

#pragma mark - life
- (instancetype)initWithFrame:(CGRect)frame
                   cellHeight:(CGFloat)cellHeight;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.delegate = self;
        self.dataSource = self;
        
        _cellHeight = cellHeight;
    }
    return self;
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    ZYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID
                                             cellSize:CGSizeMake(self.frame.size.width, _cellHeight)];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    
    // --------------- way_1 --------------- //
    // ----- no globalQueue 👇
    // simulator:   imageView != Color Blended Layer , 绿色
    // device:      FPS 估计53 , 有抖动
    
    // ----- use globalQueue 👇
    // simulator:   imageView != Color Blended Layer , 绿色
    // device:      FPS 估计57 , 微小抖
    [ZYTool zy_getCornerImageWith:[UIImage imageNamed:@"imagee"]
                        fillColor:[UIColor whiteColor]
                           ivSize:cell.imageView.bounds.size
                         complete:^(UIImage *image) {
                             
                             [cell.imageView setImage:image];
                             
                         }];
    
    // --------------- way_2 --------------- //
    // simulator:   imageView = Color Blended Layer , 红色(同UILabel)
    // device:      FPS = 流畅
//    [cell.imageView setImage:[UIImage imageNamed:@"imagee"]];
//    cell.imageView.layer.cornerRadius = cell.imageView.bounds.size.height/2;
//    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

@end
