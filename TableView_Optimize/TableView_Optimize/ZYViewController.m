//
//  ZYViewController.m
//  TableView_Optimize
//
//  Created by Ray on 2017/8/31.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import "ZYViewController.h"

#import "ZYTableView.h"

@interface ZYViewController ()

@property (nonatomic,   strong)     ZYTableView * tableView;
@end

@implementation ZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}


-(ZYTableView *)tableView{
    if(_tableView == nil){
        _tableView = [[ZYTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50) cellHeight:100];
        
    }
    return _tableView;
}

@end
