//
//  TabBtn.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "TabBtn.h"
@interface TabBtn()
@property (weak,nonatomic) UIImageView *imgView;
@property (weak,nonatomic) UILabel *label;
@end
@implementation TabBtn

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        UIImageView *imgView = [[UIImageView alloc]init];
        self.imgView = imgView;
        [self addSubview:imgView];
        
        UILabel *label = [[UILabel alloc]init];
        self.label = label;
        [self addSubview:label];
    }
    return self;
}

-(void)setImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor{
    
    self.label.text = title;
    [self.label setFont:[UIFont systemFontOfSize:10]];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.imgView.image = image;
    self.label.textColor = titleColor;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(0, 5, self.bounds.size.width, 25);
    
    self.label.frame = CGRectMake(0, 30, self.bounds.size.width, 14);
}

@end
