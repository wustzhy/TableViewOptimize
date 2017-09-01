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

#import "YYWebImage.h"

@interface ZYTableView()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic,   strong)     NSArray * urlStrArray;

@end

@implementation ZYTableView
{
    CGFloat _cellHeight;
    
    CGFloat _rowNum;
    ZCellType _cellType;
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

#pragma mark - open

- (void)setSourceNum:(NSInteger)rowNum type:(ZCellType)type;
{
    _rowNum = rowNum;  _cellType = type;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self reloadData];   // 防止 在push VC 前走该方法, 使得cellForRow不走
    });
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rowNum;
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

    switch (_cellType) {
        case ZCellType_localImage_GloabalQueueCorner:   // FPS>55 微抖
        {
            
            // --------------- way_1 --------------- //
            // ----- use globalQueue 👇
            // simulator:   imageView != Color Blended Layer , 绿色
            // device:      FPS 估计57 , 微小抖
            
            [ZYTool zy_getCornerImageWith:[UIImage imageNamed:@"imagee"]
                                fillColor:[UIColor whiteColor]
                                   ivSize:cell.imageView1.bounds.size
                                 complete:^(UIImage *image) {
                                     
                                     [cell.imageView1 setImage:image];

                                 }];
            [ZYTool zy_getCornerImageWith:[UIImage imageNamed:@"imagee"]
                                fillColor:[UIColor whiteColor]
                                   ivSize:cell.imageView2.bounds.size
                                 complete:^(UIImage *image) {
                                     
                                     [cell.imageView2 setImage:image];
                                     
                                 }];

        }
            break;
            
        case ZCellType_cornerRadius:    // 无网络图 , 本地图 , 流畅
        {
            
            // --------------- way_2 --------------- //
            // simulator:   imageView = Color Blended Layer , 红色(同UILabel)
            // device:      FPS = 流畅
            [cell.imageView1 setImage:[UIImage imageNamed:@"imagee"]];
            cell.imageView1.layer.cornerRadius = cell.imageView1.bounds.size.height/2;
            cell.imageView1.layer.masksToBounds = YES;
            
            [cell.imageView2 setImage:[UIImage imageNamed:@"imagee"]];
            cell.imageView2.layer.cornerRadius = cell.imageView2.bounds.size.height/2;
            cell.imageView2.layer.masksToBounds = YES;
            
        }
            break;
        case ZCellType_webImageMainQueueLoad:       // 卡顿明显 FPS<50
        {
            UIImage * image1 = [self loadImageWithUrlStr:self.urlStrArray[indexPath.row%self.urlStrArray.count]];
            UIImage * image2 = [self loadImageWithUrlStr:self.urlStrArray[self.urlStrArray.count-1 - indexPath.row%self.urlStrArray.count]];
            
            cell.imageView1.image = image1;
            cell.imageView2.image = image2;
        }
            break;
            
        case ZCellType_webImageYYCorner:    // FPS >55 微抖
        {
            
            [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:self.urlStrArray[indexPath.row%self.urlStrArray.count]]
                                    placeholder:[UIImage imageNamed:@"imagee"]
                                        options:kNilOptions
                                     completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                         NSLog(@"image1 finished == %@",image);
                                     }];
            
            [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:self.urlStrArray[self.urlStrArray.count-1 - indexPath.row%self.urlStrArray.count]]
                                    placeholder:[UIImage imageNamed:@"imagee"]
                                        options:kNilOptions
                                       progress:nil
                                      transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                          NSLog(@"image before transform == %@",image);
                                          return [image yy_imageByRoundCornerRadius:image.size.height/2];
                                      }
                                     completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                         NSLog(@"image2 finished == %@",image);
                                     }];
            
        }
            break;
            
        default:
            break;
    }

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}


#pragma mark - private
- (UIImage *)loadImageWithUrlStr:(NSString *)urlStr{
    NSError * error ;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]
                                          options:NSDataReadingMappedIfSafe
                                            error:&error];
    if (error) {
        NSLog(@"%@",error); // App Transport Security Settings , info.plist
    }
    UIImage * image = [UIImage imageWithData:data];
    return image;
}

#pragma mark - getter
-(NSArray *)urlStrArray{
    if(_urlStrArray == nil){
        
        _urlStrArray = @[
                          @"http://f1.iaround.com/upload/images/f69baede2e2d18fe11aa6103a5e9752b.png",
                          @"http://p1.dev.iaround.com/201708/17/FACE/f0977cd7743d1406f188d0cc9a8ac2b1.jpg",
                          @"http://statics.iaround.com/skill/skill_1_burst_3.png",
                          @"http://p1.dev.iaround.com/201707/25/FACE/385c24fa67ea7955b99fb556b7d43a0e_s.jpg",
                          @"http://statics.iaround.com/skill/skill_4_kick_3.png",
                          @"http://statics.iaround.com/skill/skill_2_kiss_3.png",
                          @"http://f1.iaround.com/upload/images/4bd138b209212a0801543e6eaa78b0df.png",
                          @"http://f1.iaround.com/upload/images/a04cf04197923b6548ee08a6feedfe03.png",
                          ];
}
    return _urlStrArray;
}

@end
