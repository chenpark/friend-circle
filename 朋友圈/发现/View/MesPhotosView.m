//
//  MesPhotosView.h
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "MesPhotosView.h"

#define margin 5
#define photoViewW ([UIScreen mainScreen].bounds.size.width-30)/3
#define photoViewH 100
@implementation MesPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//返回配图的size
-(CGSize)photoSizeWithCount:(int)count{

    int cols = (count >= 3)? 3 : count;
    // 行数
    int rows = (count + 3 - 1) / 3;
    CGFloat photosW = 0;
    
    CGFloat photosH = 0;
    
    photosW = cols * photoViewW + (cols - 1) * margin;
        
    photosH = rows * photoViewH + (rows - 1) * margin;
  
    
    return CGSizeMake(photosW, photosH);

}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = (int)photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            imageView.image = photos[i];
            imageView.hidden = NO;
        } else { // 隐藏
           imageView.hidden = YES;
        }
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    int photosCount =  (int) self.photos.count;
    int maxCol = 3;

    for (int i = 0; i<photosCount; i++) {
            
            UIImageView *photoView = self.subviews[i];
    
                int col = i % maxCol;
               CGFloat x = col * (photoViewW + margin);
                
                int row = i / maxCol;
               CGFloat y = row * (photoViewH + margin);
                
        photoView.frame = CGRectMake(x, y, photoViewW, photoViewH);

    }

}

@end
