//
//  ForbiddenScreenShotMarkView.m
//  MPFrameworkDemo_plugin
//
//  Created by macbookpro2100 on 12/20/19.
//  Copyright © macbookpro2100 All rights reserved.
//

#import "ForbiddenScreenShotMarkView.h"


typedef NS_ENUM(NSInteger, PAForbiddenScreenShotStyle) {
    PAForbiddenScreenShotStyleLightGray,        // 浅灰
    PAForbiddenScreenShotStyleGray,             // 深灰
    PAForbiddenScreenShotStyleRed               // 红色
};

static NSInteger kWaterMarkLabelCount = 7;

@interface ForbiddenScreenShotMarkView ()

// annotation:不可截屏的icon富文本text
@property(nonatomic, strong) NSMutableAttributedString *forbiddenText;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, assign) BOOL currentAllowScreenShot;
@property(nonatomic, assign) PAForbiddenScreenShotStyle style;
@property(nonatomic, strong) UIView *maskView;
@end

@implementation ForbiddenScreenShotMarkView

- (id)initWithFrame:(CGRect)frame {
    NSString *text = [self getUMID];
    self = [self initWithFrame:frame text:text fontSize:0 textColor:[UIColor colorWithRGB:0x333333 alpha:0.07]];
    return self;
}

- (id)initWithFrame:(CGRect)frame textColor:(UIColor *)color alpha:(CGFloat)alpha {
    NSString *text = [self getUMID];
    self = [self initWithFrame:frame text:text fontSize:0 textColor:color alpha:alpha];
    return self;
}

- (NSString *)getUMID {
    return @"macbookpro2100@hotmail.com";
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text fontSize:(NSUInteger)fontSize textColor:(UIColor *)color {
    self = [self initWithFrame:frame text:text fontSize:fontSize textColor:color alpha:0];
    return self;
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text fontSize:(NSUInteger)fontSize textColor:(UIColor *)color alpha:(CGFloat)alpha {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;

        self.textColor = color;

        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(-self.frame.size.width, -self.frame.size.height, 3 * self.frame.size.width, 3 * self.frame.size.height)];
        maskView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75];
        [self addSubview:maskView];
        self.maskView = maskView;
        self.maskView.hidden = YES;

        // 水印
        for (int i = 0; i < kWaterMarkLabelCount; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-self.frame.size.width * 0.5, 65 + 120 * i, self.frame.size.width * 3, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.userInteractionEnabled = NO;
            label.textColor = color ? color : [UIColor colorWithRed:0x00 / 255.0 green:0x00 / 255.0 blue:0x00 / 255.0 alpha:1.0];
            label.alpha = alpha ? alpha : 0.1;
            label.tag = 1000 + i;
            label.font = fontSize == 0 ? [UIFont systemFontOfSize:16.0] : [UIFont systemFontOfSize:fontSize];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }

        // 默认设置为不可截屏
        [self setWaterMarkIsAllowScreenShot:NO];
        self.transform = CGAffineTransformMakeRotation(-30 * (CGFloat) M_PI / 180);
    }
    return self;
}

- (NSMutableAttributedString *)forbiddenText {
    if (!_forbiddenText) {
        if ([self getUMID]) {
            _forbiddenText = [[NSMutableAttributedString alloc] initWithString:@"请勿截屏"];
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            UIImage *iconImage = nil;
            switch (self.style) {
                case PAForbiddenScreenShotStyleLightGray:
                    iconImage = [UIImage imageNamed:@"screenshot_camera1"];
                    break;
                case PAForbiddenScreenShotStyleGray:
                    iconImage = [UIImage imageNamed:@"screenshot-black"];
                    break;
                case PAForbiddenScreenShotStyleRed:
                    iconImage = [UIImage imageNamed:@"screenshot-black"];
                    break;
            }
            attach.image = iconImage;

            attach.bounds = CGRectMake(5, -4, iconImage.size.width, iconImage.size.height);
            if (attach) {
                NSAttributedString *strImage = [NSAttributedString attributedStringWithAttachment:attach];
                [_forbiddenText appendAttributedString:strImage];
            }
            // 加间隔
            [_forbiddenText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"                  "]];
        }
    }
    return _forbiddenText;
}

- (void)setWaterMarkIsAllowScreenShot:(BOOL)isAllowScreenShot {
    if (!kDemoNeedWartMarkt) {
        return;
    }
    [self changeWaterMarkWithScreenShotStyle:self.style];
    self.forbiddenText = nil;
    self.currentAllowScreenShot = isAllowScreenShot;
    NSString *textStr = [self getUMID];
    for (UIView *label in self.subviews) {
        if ([label isKindOfClass:[UILabel class]] && label.tag >= 1000) {
            UILabel *currentLabel = (UILabel *) label;
            if (isAllowScreenShot) {
                currentLabel.attributedText = nil;
                currentLabel.text = [NSString stringWithFormat:@"%@                  %@                  %@                  %@                  %@                  %@                  %@                  %@", textStr, textStr, textStr, textStr, textStr, textStr, textStr, textStr];
            } else {
                NSMutableAttributedString *currentStr = nil;
                NSMutableAttributedString *mainText = nil;
                if (label.tag % 2 == 0) {
                    currentStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.forbiddenText];
                    mainText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@                  ", textStr]];
                    [currentStr appendAttributedString:mainText];
                    [currentStr appendAttributedString:self.forbiddenText];
                    [currentStr appendAttributedString:mainText];
                    [currentStr appendAttributedString:self.forbiddenText];
                    [currentStr appendAttributedString:mainText];
                    [currentStr appendAttributedString:self.forbiddenText];
                    [currentStr appendAttributedString:mainText];
                } else {
                    currentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@                  ", textStr]];
                    mainText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@                  ", textStr]];
                    [currentStr appendAttributedString:self.forbiddenText];
                    [currentStr appendAttributedString:mainText];
                    [currentStr appendAttributedString:self.forbiddenText];
                    [currentStr appendAttributedString:mainText];
                    [currentStr appendAttributedString:self.forbiddenText];
                    [currentStr appendAttributedString:mainText];
                    [currentStr appendAttributedString:self.forbiddenText];
                }
                currentLabel.text = nil;
                currentLabel.attributedText = currentStr;
            }
        }
    }
}

- (void)didChangeLanguage:(NSString *)language {
    [self setWaterMarkIsAllowScreenShot:self.currentAllowScreenShot];
}

#pragma mark - Public Method

- (void)changeWaterMarkWithScreenShotStyle:(PAForbiddenScreenShotStyle)style {
    self.style = style;
    NSArray *waterMarkLabels = [self waterMarkLabels];
    for (UILabel *waterMarkLabel in waterMarkLabels) {
        switch (style) {
            case PAForbiddenScreenShotStyleLightGray:   // 正常水印显示
                waterMarkLabel.textColor = [UIColor colorWithRGB:0x333333];
                waterMarkLabel.alpha = 0.07;
                self.maskView.hidden = YES;
                break;
            case PAForbiddenScreenShotStyleGray:        // 水印加深
                waterMarkLabel.textColor = [UIColor colorWithRGB:0x333333];
                waterMarkLabel.alpha = 0.4;
                self.maskView.hidden = YES;
                break;
            case PAForbiddenScreenShotStyleRed:         // 红色水印+蒙层
                waterMarkLabel.textColor = [UIColor colorWithRGB:0xEC4B4B];
                waterMarkLabel.alpha = 0.4;
                self.maskView.hidden = NO;
                break;
        }
    }
}

#pragma mark - Helper

- (NSArray<UILabel *> *)waterMarkLabels {
    NSMutableArray<UILabel *> *labels = [NSMutableArray arrayWithCapacity:kWaterMarkLabelCount];
    for (int i = 0; i < kWaterMarkLabelCount; i++) {
        [labels addObject:[self viewWithTag:1000 + i]];
    }
    return [labels count] > 0 ? [labels copy] : nil;
}

#pragma mark - Getter/Setter

- (PAForbiddenScreenShotStyle)style {
//    NSString *screenShotStatus = [[NSUserDefaults standardUserDefaults] stringForKey:[NSString stringWithFormat:@"%@_SCREENSHOTSTATUS", @"umID"]];
//    if (screenShotStatus != nil && [screenShotStatus length] > 0) {
//        int status = [screenShotStatus intValue];
//        if (status <= 0) return PAForbiddenScreenShotStyleLightGray;
//        if (status <= 1) return PAForbiddenScreenShotStyleGray;
//        return PAForbiddenScreenShotStyleRed;
//    }
    return PAForbiddenScreenShotStyleLightGray;
}
@end
