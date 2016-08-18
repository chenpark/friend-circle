//
//  ImageTool.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageTool.h"

@implementation ImageTool

//把图片数组转成编码后的字符串
+(NSString *)imageArrayToString:(NSMutableArray *)arrayM{
    NSMutableString *stringM = [[NSMutableString alloc]init];
    
    for(UIImage *img in arrayM){
        ImageTool *tool = [[ImageTool alloc]init];
        NSString *str = [tool UIImageToBase64Str:img];
        [stringM appendString:[NSString stringWithFormat:@"%@&@&",str]];
    }
    return stringM;
}

//把编码后的字符串转成图片数组
+(NSMutableArray *)stringToArray:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@"@&@&"];
    NSMutableArray *arrayM = [NSMutableArray array];
    ImageTool *tool = [[ImageTool alloc]init];
    for(int i=0;i<arr.count;i++){
        //去掉多余的字符
        NSString  *s1 = [arr[i] stringByReplacingOccurrencesOfString:@"@&@&"withString:@""];
        UIImage *img = [tool Base64StrToUIImage:s1];
        [arrayM addObject:img];
    }
    return arrayM;
}

//图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

//字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:_encodedImageStr];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}


@end
