//
//  YSAlerController.h
//  perfectAlertViewController
//
//  Created by  夏浪 on 16/1/25.
//  Copyright © 2016年 Raines. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^alertActionHandler)(NSString* handle);


typedef NS_ENUM(NSInteger, otherButtonTitleClass) {
    
    otherButtonTitleClassStr = 1,
    
    otherButtonTitleClassArr,
    
    otherButtonTitleClassDic
    
};

@interface YSAlerController : NSObject <UIAlertViewDelegate>

@property (nonatomic, copy) alertActionHandler handle;

+ (instancetype)initAlertViewTitle:(NSString *)title
                           message:(NSString *)message
                          delegate:(id)delegate
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(id )otherButtonTitles
                       alertVblock:(alertActionHandler)block;


- (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
                  delegate:(id)delegate
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(id )otherButtonTitles
               alertVblock:(alertActionHandler)block;








@end


