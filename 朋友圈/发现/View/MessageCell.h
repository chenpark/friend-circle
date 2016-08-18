//
//  MessageCell.h
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;
@interface MessageCell : UITableViewCell
@property (strong,nonatomic) Message *message;
@end
