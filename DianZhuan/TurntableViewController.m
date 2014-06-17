//
//  TurntableViewController.m
//  DianZhuan
//
//  Created by 时代合盛 on 14-6-11.
//  Copyright (c) 2014年 时代合盛. All rights reserved.
//

#import "TurntableViewController.h"

@interface TurntableViewController (){
    UIImageView *image1,*image2;
    UIButton *btn_start;

    float random;
    float orign;

}

@end

@implementation TurntableViewController

- (void)loadView{
    [super loadView];
    if(IOS_7){
        self.edgesForExtendedLayout = 0;
    }
    //添加转盘
    UIImageView *image_disk = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disk.jpg"]];
    image_disk.frame = CGRectMake(0.0, 0.0, 320.0, 320.0);
    image1 = image_disk;
    [self.view addSubview:image1];
    
    //添加转针
    UIImageView *image_start = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
    image_start.frame = CGRectMake(103.0, 55.0, 120.0, 210.0);
    image2 = image_start;
    [self.view addSubview:image2];
    
    //添加按钮
    btn_start = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_start.frame = CGRectMake(130.0, 130.0, 70.0, 70.0);
    [btn_start addTarget:self action:@selector(choujiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_start];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)choujiang
{
    btn_start.enabled = NO;
    //******************旋转动画******************
    //产生随机角度
//    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    random = (arc4random() % 20000) / 10000.0;
     NSLog(@"random 01 = %f",random);
//    random = (arc4random() / 20) / 10.0;
    NSLog(@"random 02 = %f",random);
    
    float one = 0 ;
    float two = 0 ;
    float three = 0 ;
    float four = 0 ;
    float five = 0 ;
    float six = 0 ;
    float seven = 0 ;
    
    NSMutableArray *muArr = [NSMutableArray array];
    
    for (NSInteger i=0; i<20000; i++) {
        float num = (arc4random()%1000);
        float rValue = num;//fmodf(10+orign+num, 2.0);
        if (rValue<=(10)) {
//            [muArr addObject:[NSNumber numberWithFloat:num]];
            one++;
        }else if (rValue<=(30)){
            two++;
        }else if (rValue<=(60)){
            three ++;
        }else if (rValue<=(100)){
            four ++;
        }else if (rValue <=(140)){
            five ++;
        }else if (rValue <=(180.0)){
            
            six ++;
        }else if (rValue<=(1000.0)){
            
            seven ++;
            
        }
        
        
    }
    NSLog(@"运行count次数的结果为:");
    
    NSLog(@"0出现概率:%@",[NSString stringWithFormat:@"%0.2lf",(one/20000*100) ]);
    NSLog(@"1出现概率:%@",[NSString stringWithFormat:@"%0.2lf",(two/20000*100) ]);
    NSLog(@"2出现概率:%@",[NSString stringWithFormat:@"%0.2lf",(three/20000*100) ]);
    NSLog(@"3出现概率:%@",[NSString stringWithFormat:@"%0.2lf",(four/20000*100) ]);
    
    
    

//    random = (arc4random()/20000);//1-19000
    
    
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0+orign)]];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0+random+orign)]];
    [spin setDuration:5];
    [spin setDelegate:self];//设置代理，可以相应animationDidStop:finished:函数，用以弹出提醒框
    //速度控制器
    [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //添加动画
    [[image2 layer] addAnimation:spin forKey:nil];
    //锁定结束位置
    image2.transform = CGAffineTransformMakeRotation(M_PI * (10.0+random+orign));
    //锁定fromValue的位置
//    NSLog(@"random = %f",random);
//    NSLog(@"orign = %f",orign);
    orign = 10.0+random+orign;
//    NSLog(@"orign = %f",orign);
    orign = fmodf(orign, 2.0);
//    NSLog(@"orign = %f",orign);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //判断抽奖结果
    if (orign >= 0.0 && orign < (0.5/3.0)) {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 一等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }
    else if (orign >= (0.5/3.0) && orign < ((0.5/3.0)*2))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 七等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= ((0.5/3.0)*2) && orign < ((0.5/3.0)*3))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 六等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= (0.0+0.5) && orign < ((0.5/3.0)+0.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 七等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= ((0.5/3.0)+0.5) && orign < (((0.5/3.0)*2)+0.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 五等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= (((0.5/3.0)*2)+0.5) && orign < (((0.5/3.0)*3)+0.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 七等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= (0.0+1.0) && orign < ((0.5/3.0)+1.0))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 四等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= ((0.5/3.0)+1.0) && orign < (((0.5/3.0)*2)+1.0))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 七等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= (((0.5/3.0)*2)+1.0) && orign < (((0.5/3.0)*3)+1.0))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 三等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= (0.0+1.5) && orign < ((0.5/3.0)+1.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 七等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= ((0.5/3.0)+1.5) && orign < (((0.5/3.0)*2)+1.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 二等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= (((0.5/3.0)*2)+1.5) && orign < (((0.5/3.0)*3)+1.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 七等奖！ " delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
        [result show];
    }
    btn_start.enabled = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
