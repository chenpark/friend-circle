//
//  MessageCell.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "ImageTool.h"
#import "MesPhotosView.h"
@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@property (weak,nonatomic) MesPhotosView *photoView;
@property (weak, nonatomic) IBOutlet UIView *picV;

@property (strong,nonatomic) NSArray *photoA;
@end
@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}

-(NSArray *)photoA{
    if(!_photoA){
        _photoA = [[NSArray alloc]init];
    }
    return _photoA;
}

-(void)setMessage:(Message *)message{
    _message = message;
    self.icon.image = [UIImage imageNamed:@"1.png"];
    self.nameL.text = message.name;
    self.textL.text = message.text;
    
    NSArray *array = [ImageTool stringToArray:message.picString];
    self.photoA = array;
    if(array.count > 0){
        MesPhotosView *photoView = [[MesPhotosView alloc]init];
        photoView.photos = array;
        self.photoView = photoView;
        [self.picV addSubview:photoView];
         self.picV.hidden=NO;
    }else{
        self.picV.hidden = YES;
    }
    
}

//重新计算cell的frame
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
