#import "AUUILoadDefine.h"//程序自动生成
#ifdef ANTUI_UI_PopTip_AUPopTipView//程序自动生成
//
//  AUPopTipContentView.h
//  AntUI
//
//  Created by 沫竹 on 2018/3/15.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import <AntUI/AntUI.h>



typedef NS_ENUM(NSInteger,AUPopContentViewStyle) {
    AUPopContentViewStyleAUPopBar,
    AUPopContentViewStyleAUPopTip
};

@interface AUPopContentView : AUView

@property (nonatomic, assign) AUPopContentViewStyle style;
@property (nonatomic, strong) AUExpandAreaButton    *closeButton;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) AURichTextLabel *textLabel;
@property (nonatomic, strong) AURichTextLabel *descLabel;
@property (nonatomic, strong) AUButton    *button;


//普通气泡样式。
//不带左侧X按钮，纯文本 + 纯按钮
- (instancetype)initWithTitle:(NSString *)title
                  buttonTitle:(NSString *)buttonTitle;


- (instancetype)initWithText:(NSString *)text
                        icon:(UIImage *)icon
                 buttonTitle:(NSString *)buttonTitle;


- (instancetype)initWithText:(NSString *)text
                        desc:(NSString *)desc
                        icon:(UIImage *)icon
                 buttonTitle:(NSString *)buttonTitle;


- (void)setMaxWidth:(CGFloat)width;

@end


@interface AUPopTipContentView : AUPopContentView
{
    
}

@end

#endif//程序自动生成
