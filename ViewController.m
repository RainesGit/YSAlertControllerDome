//
//  ViewController.m
//  YSAlertControllerDome
//
//  Created by  夏浪 on 16/2/2.
//  Copyright © 2016年 Raines. All rights reserved.
//

#import "ViewController.h"
#import "YSAlerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
   
}
- (IBAction)showAction:(id)sender {

    /**
     第一个参数 title
     第二个参数 messege
     第三个参数 delegate 一定要给（self）
     第四个参数  取消按钮
     第五个参数  支持 nsstring （但是只能写一个字符串） 支持NSArray（随便你写多少个） 支持字典 （随便你写多少个）
     
     - returns: <#return value description#>
     */
    //    [YSAlerController initAlertViewTitle:@"This is a title" message:@"This is a AVC" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil alertVblock:^(NSString *handle) {
    //
    //        NSLog(@"%@",handle);
    //
    //    }];
    
    
    
    //     //字符串的例子
    //     [YSAlerController initAlertViewTitle:@"This is a title" message:@"This is a AVC" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"啦啦啦啦" alertVblock:^(NSString *handle) {
    //
    //     NSLog(@"%@",handle);
    //
    //     }];
    //
    
    [[YSAlerController alloc] showAlertViewTitle:@"This is a title" message:@"This is a AVC" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"你真的" alertVblock:^(NSString *handle) {
        
        NSLog(@"%@",handle);
        
    }];
    
    
    
    /*
     //数组的例子
     [YSAlerController initAlertViewTitle:@"This is a title" message:@"This is a AVC" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"你好",@"啦啦啦啦"} alertVblock:^(NSString *handle) {
     
     NSLog(@"%@",handle);
     
     }];
     */
    
    
    
    /*
     //字典的例子  字典的key 就是按键名字，而后面给的数字，1 代表需要按钮加红字， 其他都是默认颜色
     [YSAlerController initAlertViewTitle:@"This is a title" message:@"This is a AVC" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@{@"你好":@1,@"啦啦啦啦":@0} alertVblock:^(NSString *handle) {
     
     NSLog(@"%@",handle);
     
     }];
     */


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
