//
//  CYCWaterFlowLayout.h
//  瀑布流DEMO
//
//  Created by Chenpark on 2016/8/13.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYCWaterFlowLayout;

@protocol CYCWaterFlowLayoutDelegate <NSObject>
@required
/**
 *  决定cell的高度必须实现
 *
 *  @param waterFlowLayout
 *  @param index           <#index description#>
 *  @param width           <#width description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)waterFlowLayout:(CYCWaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width;
@optional
///决定cell的列数
- (NSInteger)waterFlowLayoutCloumnCount:(CYCWaterFlowLayout *)waterFlowLayout;
///决定cell 的列的距离
- (CGFloat)waterFlowLayoutColumMargin:(CYCWaterFlowLayout *)waterFlowLayout;
///决定cell 的行的距离
- (CGFloat)waterFlowLayoutRowMargin:(CYCWaterFlowLayout *)waterFlowLayout;
///决定cell 的边缘间距
- (UIEdgeInsets)waterFlowLayoutEdgeInset:(CYCWaterFlowLayout *)waterFlowLayout;

@end

@interface CYCWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property(nonatomic, weak) id<CYCWaterFlowLayoutDelegate> delegate;
- (NSInteger)colCount;
- (CGFloat)colMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)currentEdgeInsets;
@end
