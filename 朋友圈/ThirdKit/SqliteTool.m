//
//  sqliteTool.m
//  sqlLite实践
//
//  Created by Chenpark on 16/8/17.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "SqliteTool.h"
#import <sqlite3.h>
@implementation SqliteTool

static sqlite3 *_db;

+(void)initialize{
    //一个_db代表一个数据库对象
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *fullPath = [path stringByAppendingPathComponent:@"demo.sqlite"];
    
    // 1.打开数据
    // sqlite3 *db; // 一个db就代表一个数据库
    // open会先判断数据库文件是否存在, 如果不存在会自动创建数据库文件, 然后再打开数据
    // open会返回一个int类型的值, 这个值代表着打开数据库是否成功
    
    int result = sqlite3_open(fullPath.UTF8String, &_db);
    
    if(SQLITE_OK == result){
        NSLog(@"数据库打开成功");
        
        const char *sql = "CREATE TABLE IF NOT EXISTS t_stu (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, text TEXT,pic TEXT) ";
        
        char *error;
        
        /*
         第1参数:需要执行sql语句的数据库
         第2参数:需要执行的sql语句
         第3参数:执行完sql语句之后的回调方法
         第4参数:回调方法的参数
         第5参数:错误信息
         */
        
        sqlite3_exec(_db, sql, NULL, NULL, &error);
        
        if(error){
            NSLog(@"创建表失败");
        }else{
            NSLog(@"创建表成功");
        }
    }else{
        NSLog(@"打开数据库失败");
    }
    
}

//插入数据
+(void)insertData:(Message *)message{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_stu (name,text,pic) VALUES ('%@','%@','%@')",message.name,message.text,message.picString];
    
    char *error = nil;
    
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error);
    
    if(error){
        NSLog(@"数据插入失败");
        
    }else{
        NSLog(@"数据插入成功");
    }
}

//查询数据
+(NSArray *)selectData:(Message *)message{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_stu where id = '%li'",(long)message.ID];
    
    //准备查询
    sqlite3_stmt *stmt;//用于提取数据变量
    
    int result = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
    //如果查到了结果
    NSMutableArray *array = [NSMutableArray array];
    if(SQLITE_OK == result){
        
        while(SQLITE_ROW == sqlite3_step(stmt)){//如果检索到一条数据
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *text = sqlite3_column_text(stmt, 2);
            const unsigned char *pic = sqlite3_column_text(stmt, 3);
            
            Message *mes = [[Message alloc]init];
            mes.ID = ID;
            mes.name = [NSString stringWithUTF8String:name];
            mes.text = [NSString stringWithUTF8String:text];
            mes.picString = [NSString stringWithUTF8String:pic];
            
            [array addObject:mes];
        }
        return array;
    }else{
        NSLog(@"啥都没查到");
        return nil;
    }
    
    
    return array;
}

//删除数据
+(void)deleteData:(Message *)message{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_stu WHERE id = '%ld'",(long)message.ID];
    
    char *error;
    
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error);
    
    if(error){
        NSLog(@"删除失败");
    }else{
        NSLog(@"删除成功");
    }
}
@end
