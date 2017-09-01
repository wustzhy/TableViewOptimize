//
//  ZYTableView.h
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ZCellType) {
    ZCellType_localImage_GloabalQueueCorner, // 处理image圆角
    ZCellType_cornerRadius,     // 系统方式 切圆角
    
    ZCellType_webImageMainQueueLoad,    // 主线程下载图片
    ZCellType_webImageYYCorner,   // 处理网络image圆角
    
};


@interface ZYTableView : UITableView


- (instancetype)initWithFrame:(CGRect)frame
                   cellHeight:(CGFloat)cellHeight;


- (void)setSourceNum:(NSInteger)rowNum type:(ZCellType)type;

@end
