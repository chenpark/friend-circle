//
//  Message.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "Message.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define margin 10
#import "ImageTool.h"
#import "MesPhotosView.h"
@implementation Message
-(CGFloat)cellHeight{
    //如果已经计算过高度就不要在计算，这样既能避免重复调用还能避免重复计算
    if(_cellHeight != 0) return _cellHeight;
    
    _cellHeight += 80+margin;
    
    //计算正文的高度
    CGSize textSize = CGSizeMake(ScreenW - 20, MAXFLOAT);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    CGFloat textH = [self.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    //计算完了正文间距下面的高度
    _cellHeight += textH +margin;
    
    //如果有图片
    NSArray *array = [ImageTool stringToArray:self.picString];
    MesPhotosView *photoView = [[MesPhotosView alloc]init];
    CGSize size = [photoView photoSizeWithCount:array.count];
    if(array.count > 0){
        _cellHeight += size.height + margin;
    }else{
        _cellHeight += 0;
    }
    return _cellHeight;
}
@end

