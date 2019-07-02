//
//  DoraemonDBRowView.m
//  AFNetworking
//
//  Created by yixiang on 2019/4/1.
//

#import "DoraemonDBRowView.h"


@implementation DoraemonDBRowView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    for (int i = 0; i < self.dataArray.count; i++) {
        NSString *content = self.dataArray[i];
        UILabel *label = [[UILabel alloc] init];
        UIColor *color = [UIColor colorFromHexString:@"#dcdcdc"];
        if (self.type == DoraemonDBRowViewTypeForOne) {
            color = [UIColor colorFromHexString:@"#e6e6e6"];
        }
        if (self.type == DoraemonDBRowViewTypeForTwo) {
            color = [UIColor colorFromHexString:@"#ebebeb"];
        }
        label.backgroundColor = color;
        label.text = content;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)]];
        [self addSubview:label];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:UILabel.class]) {
            CGFloat width = (self.bounds.size.width - (self.dataArray.count - 1)) / self.dataArray.count;
            subView.frame = CGRectMake(subView.tag * (width + 1), 0, width, self.bounds.size.height);
        }
    }
}

- (void)tapLabel:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
    if ([self.delegate respondsToSelector:@selector(rowView:didLabelTaped:)]) {
        [self.delegate rowView:self didLabelTaped:label];
    }
}

@end
