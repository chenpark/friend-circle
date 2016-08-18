//
//  sqliteTool.h
//  sqlLite实践
//
//  Created by Chenpark on 16/8/17.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
@interface SqliteTool : NSObject

//插入数据
+(void)insertData:(Message *)message;

//查询数据
+(NSArray *)selectData;

//删除数据
+(void)deleteData:(Message *)message;
@end
