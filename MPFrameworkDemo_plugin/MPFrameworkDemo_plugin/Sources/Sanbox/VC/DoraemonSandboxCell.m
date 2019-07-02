//
//  DoraemonSandboxCell.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2017/12/11.
//

#import "DoraemonSandboxCell.h"
#import "DoraemonSandboxModel.h"
#import "DoraemonUtil.h"

@interface DoraemonSandBoxCell ()

@property(nonatomic, strong) UIImageView *fileTypeIcon;
@property(nonatomic, strong) UILabel *fileTitleLabel;
@property(nonatomic, strong) UILabel *fileSizeLabel;

@end

@implementation DoraemonSandBoxCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.fileTypeIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.fileTypeIcon];

        self.fileTitleLabel = [[UILabel alloc] init];
        self.fileTitleLabel.font = [UIFont systemFontOfSize:18];
        self.fileSizeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.fileTitleLabel];

        self.fileSizeLabel = [[UILabel alloc] init];
        self.fileSizeLabel.font = [UIFont systemFontOfSize:16];
        self.fileSizeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.fileSizeLabel];
    }
    return self;
}

- (void)renderUIWithData:(DoraemonSandboxModel *)model {
    NSString *iconName = nil;
    if (model.type == DoraemonSandboxFileTypeDirectory) {
        iconName = @"doraemon_dir";
    } else {
        iconName = @"doraemon_file_2";
    }
    self.fileTypeIcon.image = [UIImage imageNamed:iconName];
    [self.fileTypeIcon sizeToFit];
    self.fileTypeIcon.frame = CGRectMake(15, [[self class] cellHeight] / 2 - self.fileTypeIcon.height / 2, self.fileTypeIcon.width, self.fileTypeIcon.height);

    self.fileTitleLabel.text = model.name;
    self.fileTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.fileTitleLabel sizeToFit];
    self.fileTitleLabel.frame = CGRectMake(45, [[self class] cellHeight] / 2 - self.fileTitleLabel.height / 2, AUCommonUIGetScreenWidth() - 150, self.fileTitleLabel.height);

    DoraemonUtil *util = [[DoraemonUtil alloc] init];
    [util getFileSizeWithPath:model.path];
    NSInteger fileSize = util.fileSize;
    //将文件夹大小转换为 M/KB/B
    NSString *fileSizeStr = nil;
    if (fileSize > 1024 * 1024) {
        fileSizeStr = [NSString stringWithFormat:@"%.2fM", fileSize / 1024.00f / 1024.00f];

    } else if (fileSize > 1024) {
        fileSizeStr = [NSString stringWithFormat:@"%.2fKB", fileSize / 1024.00f];

    } else {
        fileSizeStr = [NSString stringWithFormat:@"%.2fB", fileSize / 1.00f];
    }

    self.fileSizeLabel.text = fileSizeStr;
    [self.fileSizeLabel sizeToFit];
    self.fileSizeLabel.frame = CGRectMake(AUCommonUIGetScreenWidth() - 15 - self.fileSizeLabel.width, [[self class] cellHeight] / 2 - self.fileSizeLabel.height / 2, self.fileSizeLabel.width, self.fileSizeLabel.height);
}

+ (CGFloat)cellHeight {
    return 48.;
}

@end
