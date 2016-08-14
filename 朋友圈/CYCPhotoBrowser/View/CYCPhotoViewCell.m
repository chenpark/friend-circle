//
//  CYCPhotoViewCell.m
//  CYCPhotoBrowser
//
//  Created by Chenpark on 2016/8/13.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "CYCPhotoViewCell.h"
#import "CYCPhoto.h"

@interface CYCPhotoViewCell()

/** 图片 */
@property(nonatomic, strong) UIImageView *bodyImageView;
/** 选中 */
@property(nonatomic, strong) UIImageView *checkView;
@end
@implementation CYCPhotoViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bodyImageView];
        [self addSubview:self.checkView];
    }
    return self;
}

- (UIImageView *)bodyImageView {
    if (!_bodyImageView) {
        _bodyImageView =  [[UIImageView alloc] init];
        _bodyImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bodyImageView.clipsToBounds = YES;
    }
    return _bodyImageView;
}

- (UIImageView *)checkView {
    if (!_checkView) {
        _checkView =  [[UIImageView alloc] init];
        _checkView.image = [UIImage imageNamed:@"checked"];
        _checkView.hidden = YES;
    }
    return _checkView;
}



- (void)setPhoto:(CYCPhoto *)photo {
    _photo = photo;
    self.bodyImageView.image = photo.image;
    self.checkView.hidden = !photo.isChecked;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bodyImageView.frame = self.bounds;
    CGFloat checkWH = 27;
    CGFloat margin = 10;
    self.checkView.frame = CGRectMake(self.bounds.size.width - checkWH - margin, self.bounds.size.height - checkWH - margin, checkWH, checkWH);
}
@end
