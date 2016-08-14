//
//  SendMsgViewController.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "SendMsgViewController.h"
#define screenW [UIScreen mainScreen].bounds.size.width
#import "UIView+Frame.h"
#import "CYCPhotoViewController.h"
#import "CYCPhoto.h"
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
@interface SendMsgViewController () <CYCPhotoViewControllerDelegate,CLLocationManagerDelegate>
@property (weak,nonatomic) UITextField *tf;
@property (weak,nonatomic) UITextView *tfV;
@property (strong,nonatomic) NSArray *photos;
@property (weak,nonatomic) UIView *picView;
@property (strong,nonatomic) NSString *loc;
@end

@implementation SendMsgViewController

-(NSArray *)photos{
    if(!_photos){
        _photos = [[NSArray alloc]init];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    [self setMsgView];
    
}


-(void)setMsgView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 44, screenW, 560)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 20, 200, 30)];
    tf.placeholder = @"请输入你的大名";
    tf.xmg_centerX = screenW/2;
    tf.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:tf];
    self.tf = tf;
    
    UITextView *tfV = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, 400, 200)];
    tfV.xmg_centerX = screenW/2;
    tfV.text = @"说点什么吧，小伙子";
    tfV.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:tfV];
    self.tfV = tfV;
    
    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(0, 270, 400, 200)];
    picView.xmg_centerX = screenW/2;
    picView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:picView];
    self.picView = picView;
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 140, 90, 50)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor whiteColor]];
    [addBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTag:2];
    [picView addSubview:addBtn];
    
    UIButton *submit = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, 50, 30)];
    submit.xmg_centerX = screenW/3;
    [submit setBackgroundColor:[UIColor greenColor]];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [view addSubview:submit];
    [submit addTarget:self action:@selector(submitData) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, 50, 30)];
    cancle.xmg_centerX = screenW*2/3;
    [cancle setBackgroundColor:[UIColor greenColor]];
    [cancle setTitle:@"清空" forState:UIControlStateNormal];
    [view addSubview:cancle];
    [cancle addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addPic{
    //添加图片
    CYCPhotoViewController * photoVc = [[CYCPhotoViewController alloc]init];
    photoVc.navigationItem.title = @"相册";
    
    UINavigationController *navPic = [[UINavigationController alloc]initWithRootViewController:photoVc];
    photoVc.delegate = self;
    [self presentViewController:navPic animated:NO completion:nil];
}

-(void)photoViewController:(CYCPhotoViewController *)photoViewController didEndSelectedPhotos:(NSArray<CYCPhoto *> *)photos{
    
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = 90;
    CGFloat imgH = 50;
    CGFloat margin = 10;
    
    if(self.picView.subviews.count == 1){
        for(int i=0;i<photos.count;i++){
            UIButton *btn = [[UIButton alloc]init];
            CYCPhoto *photo = photos[i];
            [btn setBackgroundImage:photo.image forState:UIControlStateNormal];
            imgX = (i%4)*imgW+(i%4+1)*margin;
            imgY = (i/4)*imgH+(i/4+1)*margin;
            btn.frame = CGRectMake(imgX, imgY, imgW, imgH);
            [self.picView addSubview:btn];
            
            [btn addTarget:self action:@selector(delBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        
        if(photos.count + self.picView.subviews.count >10){
            [SVProgressHUD showErrorWithStatus:@"添加的图片总数不能超过9张"];
            return;
        }else{
        
            for(int i=0;i<photos.count;i++){
                UIButton *btn = [[UIButton alloc]init];
                CYCPhoto *photo = photos[i];
                [btn setBackgroundImage:photo.image forState:UIControlStateNormal];
                [self.picView addSubview:btn];
                
                [btn addTarget:self action:@selector(delBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        for(int i=0;i<self.picView.subviews.count;i++){
            
            if(self.picView.subviews[i].tag != 2){
                imgX = (i-1)%4*imgW+((i-1)%4+1)*margin;
                imgY = ((i-1)/4)*imgH+((i-1)/4+1)*margin;
                self.picView.subviews[i].frame = CGRectMake(imgX, imgY, imgW, imgH);
            }
        }
    }
}

-(void)delBtn:(UIButton *)btn{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"标题" message:@"确定删除该张图片么" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //如果确定删除图片，要将该图片移除并且重新布局
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [btn removeFromSuperview];
        CGFloat imgX = 0;
        CGFloat imgY = 0;
        CGFloat imgW = 90;
        CGFloat imgH = 50;
        CGFloat margin = 10;
        for(int i=0;i<self.picView.subviews.count;i++){
            if(self.picView.subviews[i].tag != 2){
                imgX = (i-1)%4*imgW+((i-1)%4+1)*margin;
                imgY = ((i-1)/4)*imgH+((i-1)/4+1)*margin;
                self.picView.subviews[i].frame = CGRectMake(imgX, imgY, imgW, imgH);
            }
        }
    }];
    [alertVc addAction:cancelAction];
    [alertVc addAction:okAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

-(void)clear{
    for(UIView *view in self.picView.subviews){
        if(view.tag != 2){
            [view removeFromSuperview];
        }
    }
    self.tf.placeholder = @"请输入你的小名";
    self.tfV.text = @"说点什么吧，小伙子";
}

//存储数据到本地数据库
-(void)submitData{
    
}
@end
