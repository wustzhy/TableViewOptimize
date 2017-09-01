//
//  ViewController.m
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//


#import "ViewController.h"

#import "ZYViewController.h"


@interface ViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic,   strong)     UITableView * tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cID = @"cID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cID];
        
    }
    
    NSString * numStr = [NSString stringWithFormat:@"%zd - ",indexPath.row];
    switch (indexPath.row) {
        case ZCellType_localImage_GloabalQueueCorner:
            cell.textLabel.text = [numStr stringByAppendingString:@"本地资源图>>gcd切圆"];
            break;
            
        case ZCellType_cornerRadius:
            cell.textLabel.text = [numStr stringByAppendingString:@"本地资源图>>系统圆角处理"];
            break;
            
        case ZCellType_webImageMainQueueLoad:
            cell.textLabel.text = [numStr stringByAppendingString:@"网络资源图>>主线程下载"];
            break;
            
        case ZCellType_webImageYYCorner:
            cell.textLabel.text = [numStr stringByAppendingString:@"网络资源图>>YY下载>>YY画圆"];
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYViewController * vc = [[ZYViewController alloc]init];
    vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    vc.type = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
