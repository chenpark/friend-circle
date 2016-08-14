//
//  MainViewController.m
//  朋友圈
//
//  Created by Chenpark on 16/2/21.
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "MainViewController.h"
#import "TabBtn.h"
#import "UIView+Frame.h"
#import "SendMsgViewController.h"
#import "DiscoverViewController.h"
#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW [UIScreen mainScreen].bounds.size.width
#define tabH 44
@interface MainViewController () <UIScrollViewDelegate>
@property (weak,nonatomic) TabBtn *msgBtn;
@property (weak,nonatomic) TabBtn *disBtn;
@property (weak,nonatomic) UIScrollView *scrollView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    //添加子控制器
    [self setAllControllers];
    
    //添加scrollView
    [self setScrollView];
    
    [self setTabBarView];
 
    [self setViewWithTag:0];
}
//自定义底部导航
-(void)setTabBarView{
    
    UIView *tab = [[UIView alloc]initWithFrame:CGRectMake(0, screenH-44, screenW, tabH)];
    [tab setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:tab];
    //添加自定义按钮
    TabBtn *msgBtn = [[TabBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    msgBtn.xmg_centerX = screenW/4;
    [msgBtn setImage:[UIImage imageNamed:@"Message_normal"] title:@"消息" titleColor:[UIColor grayColor]];
    
    [tab addSubview:msgBtn];
    [msgBtn setTag:0];
    [msgBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.msgBtn = msgBtn;
    
    TabBtn *disBtn = [[TabBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    disBtn.xmg_centerX = screenW*2/3;
    [disBtn setImage:[UIImage imageNamed:@"Square_normal"] title:@"发现" titleColor:[UIColor grayColor]];
    
    [tab addSubview:disBtn];
    [disBtn setTag:1];
    [disBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.disBtn = disBtn;
    
    [self click:self.msgBtn];
 
}

-(void)click:(TabBtn *)btn{
    [self setViewWithTag:btn.tag];
    if(btn.tag == 0){
        [self.msgBtn setImage:[UIImage imageNamed:@"Message_selected"] title:@"消息" titleColor:[UIColor redColor]];
        [self.disBtn setImage:[UIImage imageNamed:@"Square_normal"] title:@"发现" titleColor:[UIColor grayColor]];
    }else{
        [self.msgBtn setImage:[UIImage imageNamed:@"Message_normal"] title:@"消息" titleColor:[UIColor grayColor]];
        [self.disBtn setImage:[UIImage imageNamed:@"Square_selected"] title:@"发现" titleColor:[UIColor redColor]];
    }
    
     self.scrollView.contentOffset = CGPointMake((btn.tag)*screenW, 0);
}

-(void)setAllControllers{
    [self addChildViewController:[[SendMsgViewController alloc]init]];
    [self addChildViewController:[[DiscoverViewController alloc]init]];
}

-(void)setScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    scrollView.contentSize = CGSizeMake(screenW*2, 0);
    //必须设置scrollView的frame不然滑动时没效果的
     scrollView.frame = self.view.bounds;
    //不让自动调节scrollView内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    scrollView.delegate = self;
}

-(void)setViewWithTag:(NSInteger)index{
    UIViewController *vc = self.childViewControllers[index];
    if([vc isViewLoaded]) return;
    
    vc.view.xmg_x = index*screenW;
    vc.view.xmg_y = 0;
    vc.view.xmg_width = screenW;
    
    vc.view.xmg_height = screenH;
    [self.scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger count = scrollView.contentOffset.x / screenW;
    
    if(count == 0){
        [self click:self.msgBtn];
    }else{
        [self click:self.disBtn];
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate == NO){
        
        NSInteger count = scrollView.contentOffset.x / screenW;
        
        if(count == 0){
            [self click:self.msgBtn];
        }else{
            [self click:self.disBtn];
        }
    }
}
@end
