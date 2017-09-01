//
//  ZYViewController.m
//  TableView_Optimize
//
//  Created by Ray on 2017/8/31.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import "ZYViewController.h"

@interface ZYViewController ()

@property (nonatomic,   strong)     ZYTableView * tableView;
@end

@implementation ZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setType:(ZCellType)type
{
    [self.view addSubview:self.tableView];
    [self.tableView setSourceNum:50 type:(ZCellType)type];
}

-(ZYTableView *)tableView{
    if(_tableView == nil){
        _tableView = [[ZYTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50) cellHeight:100];
        
    }
    return _tableView;
}

@end
