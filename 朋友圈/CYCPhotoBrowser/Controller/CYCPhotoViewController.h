//
//  CYCPhotoViewController.h
//  CYCPhotoBrowser
//
//  Created by Chenpark on 2016/8/13.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
@class CYCPhotoViewController,CYCPhoto;
@protocol CYCPhotoViewControllerDelegate<NSObject>
@optional
- (void)photoViewController:(CYCPhotoViewController *)photoViewController didEndSelectedPhotos:(NSArray <CYCPhoto *> *)photos;

@end
@interface CYCPhotoViewController : UIViewController
/** 完成选择图片代理 */
@property(nonatomic, weak) id<CYCPhotoViewControllerDelegate> delegate;
@end
