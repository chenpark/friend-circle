//
//  CYCPhotoViewCell.h
//  CYCPhotoBrowser
//
//  Created by Chenpark on 2016/8/13.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYCPhoto;
@interface CYCPhotoViewCell : UICollectionViewCell
/** 模型数据 */
@property(nonatomic, strong) CYCPhoto *photo;
@end
