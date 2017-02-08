//
//  ViewController.m
//  saolei
//
//  Created by 陈琰 on 2017/2/7.
//  Copyright © 2017年 chenyan. All rights reserved.
//

#import "ViewController.h"

// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()
{
    bool bLei[81];
    bool bStrat;
    UIButton *pBtn[81];
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    bStrat = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //绘制方格
    int Dev =  (SCREEN_WIDTH/3*2)/9;
    int nHalfWidth = SCREEN_WIDTH/6 - 1*9/2;
    int nHalfHeight = (SCREEN_HEIGHT - (1*9 + 9*Dev))/2;
    
    for (int i = 0; i< 9; i++ )
    {
        for (int j = 0; j< 9; j++ )
        {
            pBtn[j+i*9]       = [[UIButton alloc] initWithFrame:CGRectMake(j*Dev+j+nHalfWidth, i*Dev + i + nHalfHeight, Dev, Dev)];
            pBtn[j+i*9].backgroundColor = [UIColor grayColor];
            pBtn[j+i*9].tag             = j+i*9;
            
            //设置圆角的大小
            pBtn[j+i*9].layer.cornerRadius = 3;
            //此行代码必须有（UIView例外）
            pBtn[j+i*9].layer.masksToBounds = YES;
            pBtn[j+i*9].titleLabel.font = [UIFont systemFontOfSize:15];
            [pBtn[j+i*9] addTarget:self action:@selector(clickdoneWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:pBtn[j+i*9]];
            
            bLei[j+i*9] = false;
        }
    }
}

-(void) clickdoneWithButton:(UIButton*)sender
{
    //点击第一次分布雷的位置和个数
    if (!bStrat) {
        bStrat = true;
        [self randomLei:(int)sender.tag];
        [sender setTitle:[NSString stringWithFormat:@"%d",0] forState:UIControlStateNormal];
    }
    else{
        
    }
}

//随机分布雷的位置
-(void)randomLei:(int) btnTag
{
    int value = (arc4random() % 30) + 20;
    for (int n = 0; n<value; n++)
    {
        int nItem = (arc4random() % 81) + 1;
        
        if (!bLei[nItem - 1] && btnTag != nItem - 1)
        {
            bLei[nItem - 1] = true;
        }
    }
}

-(int) jishuan:(int) btnTag
{
    if (bLei[btnTag]) {
        return  -1;
    }
    
    int nSum = 0;
    int nItem = 0;
    
    //第一种可能
    if (btnTag < 9 )
    {
        nItem = btnTag - 1;
      
        //第一排
        if (nItem < 0)
        {
            nItem = btnTag + 1;
            if (bLei[nItem])
            {
                nSum++;
            }
        }
        else
        {
            if (bLei[nItem])
            {
                nSum++;
            }

            nItem = btnTag + 1;
            
            if ( nItem < 9 )
            {
                if (bLei[nItem])
                {
                    nSum++;
                }
            }
        }
        //第二排
        if (btnTag%8 == 0) {
            nItem = btnTag + 8;
        }
        else{
            
        }
        
        
    }
    else if(btnTag > 71){
        
    }
    else{
        
    }
    
    
//    if (n < 0 ){
//        n = 0;
//    }
//    if (bLei[n++]) {
//        nSum++;
//    }
//    if (bLei[n++]) {
//        nSum++;
//    }
//    if (bLei[n]) {
//        nSum++;
//    }
    
    return nSum;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
