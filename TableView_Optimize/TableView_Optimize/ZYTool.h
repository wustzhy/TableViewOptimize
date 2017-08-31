//
//  ZYTool.h
//  TableView_Optimize
//
//  Created by Ray on 2017/8/30.
//  Copyright © 2017年 Yestin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ZYTool : NSObject

+(void)zy_getCornerImageWith:(UIImage *)originImage fillColor:(UIColor *)fColor ivSize:(CGSize)size complete:(void(^)(UIImage *))finishBlock;

@end
