//
//  CYCPhoto.h
//  CYCPhotoBrowser
//
//  Created by Chenpark on 2016/8/9.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYCPhoto : NSObject
/** 图片 */
@property(nonatomic, strong) UIImage *image;
/** 选中状态 */
@property(nonatomic, assign, getter=isChecked) BOOL checked;
@end
