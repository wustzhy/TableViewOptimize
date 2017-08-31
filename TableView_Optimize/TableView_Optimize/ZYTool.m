//
//  ZYTool.m
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import "ZYTool.h"


@implementation ZYTool


+(void)zy_getCornerImageWith:(UIImage *)originImage fillColor:(UIColor *)fColor ivSize:(CGSize)size complete:(void(^)(UIImage *))finishBlock;
{
    //NSTimeInterval start = CACurrentMediaTime();
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1. 上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 2. 填充色
        [fColor setFill];
        UIRectFill(rect);
        
        // 3. 贝塞尔   Oval椭圆
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        // 裁剪
        [path addClip];
        
        // 4. 绘图
        [originImage drawInRect:rect];
        
        // 5. 获取结果
        UIImage * result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 6. 关闭 上下文
        UIGraphicsEndImageContext();
        
        //NSLog(@"%f",CACurrentMediaTime() - start);  // 0.012150 耗时操作
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            finishBlock(result);
        });
        
    });
}

@end
