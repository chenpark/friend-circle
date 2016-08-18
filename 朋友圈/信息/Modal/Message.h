//
//  Message.h
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (assign,nonatomic) NSInteger ID;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSString *picString;
@end
