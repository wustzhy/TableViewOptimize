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
        case 0:
            cell.textLabel.text = [numStr stringByAppendingString:@"本地资源图>>切圆角"];
            break;
            
        case 1:
            cell.textLabel.text = [numStr stringByAppendingString:@"网络资源图>>下载>>画圆"];
            break;
            
            
        default:
            break;
    }
    
    return cell;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
