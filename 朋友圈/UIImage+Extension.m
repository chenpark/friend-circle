//
//  UIImage+Extension.m
//  BuDeJie
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
//禁止图片渲染分类
+(instancetype)originalImageNamed:(NSString *)named{
    UIImage *image = [UIImage imageNamed:named];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



+ (UIImage *)createImageWithColor:(UIColor *)color {
    //根据颜色生成图片
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect); //联系显示区域
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    
    UIGraphicsEndImageContext(); //消除画笔
    
    return image;
    
}

@end
