//
//  ImageTool.h
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTool : NSObject
//把图片数组转成编码后的字符串
+(NSString *)imageArrayToString:(NSMutableArray *)arrayM;

//把编码后的字符串转成图片数组
+(NSMutableArray *)stringToArray:(NSString *)str;
@end
