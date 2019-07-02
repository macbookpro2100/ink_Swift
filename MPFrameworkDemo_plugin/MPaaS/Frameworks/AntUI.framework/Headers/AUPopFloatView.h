//
//  AUPopFloatView.h
//  AntUI
//
//  Created by Wang on 2018/10/1.
//  Copyright © 2018 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>




NS_ASSUME_NONNULL_BEGIN

@class AUPopFloatView;

@protocol AUPopFloatViewDelegate <NSObject>
@required
//点击控件回调
-(void) auPopFoloatViewDidClicked:(AUPopFloatView*)floatView;


//控件被挪出屏幕
-(void) auPopFoloatViewDidMoveOutOfX:(AUPopFloatView*)floatView;

@end

@interface AUPopFloatView : UIControl

@property (nonatomic,weak) id<AUPopFloatViewDelegate> delegate;

- (id) initWithLeftIcon:(UIImage*)icon
                  text:(NSString*) text;


- (void) showInView:(UIView*)view atPoint:(CGPoint) point animated:(BOOL) animated;
- (void) dismiss:(BOOL)animated;

@end

/**
 * 带白色返回箭头的PopFloatView;
 *
 */
AUPopFloatView *AUPopFloatBackArrowView(NSString* text);

NS_ASSUME_NONNULL_END


