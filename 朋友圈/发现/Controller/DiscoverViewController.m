//
//  DiscoverViewController.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SqliteTool.h"
#import "Message.h"
#import "ImageTool.h"
#import "MessageCell.h"
@interface DiscoverViewController ()
@property (strong,nonatomic) NSArray *mes;
@end

@implementation DiscoverViewController
-(NSArray *)mes{
    if(!_mes){
    _mes = [[NSArray alloc]init];
    }
    return _mes;
}

static NSString *identifier = @"message";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *array = [SqliteTool selectData];
    self.mes = array;

    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:identifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    Message *mes = self.mes[indexPath.row];
    cell.message = mes;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *mes = self.mes[indexPath.row];
    return mes.cellHeight;
}
@end
