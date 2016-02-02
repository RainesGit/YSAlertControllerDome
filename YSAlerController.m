//
//  YSAlerController.m
//  perfectAlertViewController
//
//  Created by  Raines on 16/1/25.
//  Copyright © 2016年 Raines. All rights reserved.
//






#import "YSAlerController.h"


@interface YSAlerController() 

    
@property (nonatomic, weak) id alertDelegate;

@property (nonatomic, strong) id hold;

@property (nonatomic, strong) NSString *cancelButtonTitleStr;

@property (nonatomic, strong) NSArray *otherButtonTitleArr; // 若有数组传入，数组接收

@property (nonatomic, strong) NSString *otherButtonTitlesStr; // 若有字符串传入，字符串接收

@property (nonatomic, strong) NSDictionary *otherButtonTitlesDic; // 若有字典传入，字典接收

@property (nonatomic, assign) otherButtonTitleClass otherButtonTitleClasses;
@end

@implementation YSAlerController


+ (instancetype)initAlertViewTitle:(NSString *)title
                           message:(NSString *)message
                          delegate:(id)delegate
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(id )otherButtonTitles
                       alertVblock:(alertActionHandler)block
{
    
    YSAlerController *avc = [[self alloc] init];

    [avc showAlertViewTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles alertVblock:block];
     
    return avc;
}


- (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
                  delegate:(id)delegate
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(id )otherButtonTitles
               alertVblock:(alertActionHandler)block
{
    
    self.cancelButtonTitleStr = cancelButtonTitle;
    
    self.handle = block;

    self.alertDelegate = delegate;
  
    self.hold = self;
    // 取消按钮
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (self.handle)  self.handle (action.title);
    }];
    
   self.otherButtonTitleClasses = [self checkotherButtonTitles:otherButtonTitles];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
   UIAlertController * myAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        switch (self.otherButtonTitleClasses) {
            case otherButtonTitleClassStr:
            {
                UIAlertAction *otherButtonTitle = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (self.handle) self.handle (action.title);
                }];
                
                [myAlertController addAction:otherButtonTitle];
            }
                break;
            case otherButtonTitleClassArr:
            {
                for (int i = 0; i < self.otherButtonTitleArr.count; i++) {
                    
                    UIAlertAction *otherButtonTitle = [UIAlertAction actionWithTitle:otherButtonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (self.handle) {
                            self.handle (action.title);
                        }
                        
                    }];
                    
                    [myAlertController addAction:otherButtonTitle];
                    
                }
            }
                break;
            case otherButtonTitleClassDic:
            {
                
                
                NSArray * keyArr = [self.otherButtonTitlesDic allKeys];
                
                for (int i = 0 ; i < keyArr.count ; i ++) {
                    UIAlertActionStyle  style;
                    if ([self.otherButtonTitlesDic[keyArr[i]] integerValue] == 1) {
                       style = UIAlertActionStyleDestructive;
                    }else{
                        style = UIAlertActionStyleDefault;
                    }
                    
                    UIAlertAction *otherButtonTitle = [UIAlertAction actionWithTitle:keyArr[i] style:style handler:^(UIAlertAction * _Nonnull action) {
                        if (self.handle) {
                            self.handle (action.title);
                        }
                        
                    }];
                    
                    [myAlertController addAction:otherButtonTitle];
                    
                }
            }
                break;
                
            default:
                break;
        }
                    // 加上取消按钮
                    [myAlertController addAction:cancelAlertAction];
                    // 弹出
                    [self.alertDelegate presentViewController:myAlertController animated:YES completion:^{
                        
                    }];
        
        
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    
        switch ([self checkotherButtonTitles:otherButtonTitles]) {
            case otherButtonTitleClassStr:
                [alert addButtonWithTitle:self.otherButtonTitlesStr];
                break;
            case otherButtonTitleClassArr:
            {
                
                for (int i = 0; i < self.otherButtonTitleArr.count; i++) {
            
                    [alert addButtonWithTitle:self.otherButtonTitleArr[i]];
                }
            }
                break;
            case otherButtonTitleClassDic:
            {
                NSArray *keyArr = [self.otherButtonTitlesDic allKeys];
                for (int i = 0; i< keyArr.count; i ++) {
                    
                     [alert addButtonWithTitle:keyArr[i]];
                }
                
            }
                break;

        }

        [alert addButtonWithTitle:cancelButtonTitle];
    
        [alert show];
   
    }
    
    
        
}


#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSArray *keyArr = [self.otherButtonTitlesDic allKeys];
    // 如果输入的只是数组
    if (buttonIndex >= 0 && buttonIndex < self.otherButtonTitleArr.count && self.otherButtonTitleClasses == otherButtonTitleClassArr) {
        
        if (self.handle) {
            
            self.handle ([self.otherButtonTitleArr objectAtIndex:buttonIndex]);
        }
    }
    else if (self.otherButtonTitleArr.count >= 2 && buttonIndex == self.otherButtonTitleArr.count&& self.otherButtonTitleClasses == otherButtonTitleClassArr)
    {
        if (self.handle) {
            
            self.handle (self.cancelButtonTitleStr);
        }
    
    }
    
    // 如果输入的只是字符串
    else if (self.otherButtonTitleArr.count == 0 && self.otherButtonTitlesDic == nil && self.otherButtonTitleClasses == otherButtonTitleClassStr)
    {
        if (self.handle) {
            if (buttonIndex == 0)   self.handle (self.otherButtonTitlesStr);
            else     self.handle (self.cancelButtonTitleStr);
        }
    
    }
    
    //  传进来的是字典的话。
   else if (buttonIndex >= 0 && buttonIndex < keyArr.count && self.otherButtonTitleClasses == otherButtonTitleClassDic) {
        
        if (self.handle) {
            
            self.handle ([keyArr objectAtIndex:buttonIndex]);
        }
    }
    else if (keyArr.count >= 2 && buttonIndex == keyArr.count&& self.otherButtonTitleClasses == otherButtonTitleClassDic)
    {
        if (self.handle) {
            
            self.handle (self.cancelButtonTitleStr);
        }
        
    }
    else
    {
        if (self.handle) {
            
            self.handle (self.cancelButtonTitleStr);
        }
    }
    
    

}


/**
 *  不将hold 置为nil  会一直死循环， 不被释放，造成内存泄露
 */
-(void)dismiss {
    
    self.hold = nil;
    
}


- (void)alertViewCancel:(UIAlertView *)alertView {
    
    [self dismiss]; //必须调用，把holder置为nil, 否则最后self释放不了，会内存泄漏

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    [self dismiss]; //必须调用，把holder置为nil, 否则最后self释放不了，会内存泄漏

}


/**
 *  检测   checkotherButtonTitles 是什么class
 *
 *  @param checkotherButtonTitle checkotherButtonTitle description
 *
 *  @return
 */
- (otherButtonTitleClass) checkotherButtonTitles:(id)checkotherButtonTitle
{
    if ([checkotherButtonTitle isKindOfClass:[NSArray class]]) {
        
        self.otherButtonTitleArr = checkotherButtonTitle;
        
        return otherButtonTitleClassArr;
    }
    else if ([checkotherButtonTitle isKindOfClass:[NSString class]]) {
        
        self.otherButtonTitlesStr = checkotherButtonTitle;
        
        return otherButtonTitleClassStr;
    }
    else if ([checkotherButtonTitle isKindOfClass:[NSDictionary class]])
    {
        
        self.otherButtonTitlesDic = checkotherButtonTitle;
        
        return otherButtonTitleClassDic;
    }
    
    return 0;
}


- (NSArray *)otherButtonTitleArr
{
    if (!_otherButtonTitleArr) {
        _otherButtonTitleArr = [NSArray array];
    }
    return _otherButtonTitleArr;
}

@end
