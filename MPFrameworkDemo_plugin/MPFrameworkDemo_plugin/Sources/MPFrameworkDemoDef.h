//
//  MPFrameworkDemoDef.h
//  MPFrameworkDemo
//
//  Created by shifei.wkp on 2018/12/18.
//  Copyright © 2018 alipay. All rights reserved.
//

#ifndef MPFrameworkDemoDef_h
#define MPFrameworkDemoDef_h

#define BUTTON_WITH_ACTION(_title, _sel)  \
{   \
    AUButton *button = [AUButton buttonWithStyle:AUButtonStyle1 title:_title target:self action:@selector(_sel)];    \
    button.frame = CGRectMake(hMargin, vPadding + (index++) * (height + vMargin), width, height);   \
    [scrollView addSubview:button]; \
}

#define CREATE_UI(_addButton)   \
{   \
    UIScrollView *scrollView = [[UIScrollView alloc] init];  \
    [self.view addSubview:scrollView];  \
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {    \
        make.top.mas_equalTo(self.mas_topLayoutGuide);  \
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);    \
        make.left.mas_equalTo(self.view.mas_left);  \
        make.right.mas_equalTo(self.view.mas_right);    \
    }]; \
    CGFloat hMargin = 0.05 * self.view.width, vMargin = 15; \
    CGFloat width = self.view.width - 2 * hMargin, height = 44; \
    NSInteger index = 0;    \
    CGFloat vPadding = 50;  \
    _addButton  \
    CGFloat maxY = 2 * vPadding + (index - 1) * (height + vMargin) + height;    \
    if (maxY > scrollView.height) { \
        scrollView.contentSize = CGSizeMake(scrollView.width, maxY);    \
    }   \
}





//加载的【UI 模块】
#define ANTUI_UI_BaseComponent_AUPageControl
#define ANTUI_UI_BadgeView_AUBadgeView
#define ANTUI_UI_QRCode_AUQRCodeView
#define ANTUI_UI_Search_AUSearchController
#define ANTUI_UI_Navigate_AUVerticalTabView
#define ANTUI_UI_TitleBar_AUMenuTitleView
#define ANTUI_UI_NetError_AUNetErrorView
#define ANTUI_UI_alert_AUOperationResultDialog
#define ANTUI_UI_BaseComponent_AUView
#define ANTUI_UI_pickerView_AUCascadePicker
#define ANTUI_UI_pickerView_AUCustomDatePicker
#define ANTUI_UI_alert_AUAuthorizeDialog
#define ANTUI_UI_textfields_AUSixPwdInputBox
#define ANTUI_UI_BaseComponent_AUButton
#define ANTUI_UI_PopTip_AUPopBar
#define ANTUI_UI_refreshLoadingView_AULoadingView
#define ANTUI_UI_Tableview_AUDoubleTitleListItem
#define ANTUI_UI_alert_AUListDialog
#define ANTUI_UI_TitleBar_AUDoubleTitleView
#define ANTUI_UI_Label_AURichLayer
#define ANTUI_UI_BaseComponent_AUCollectionView
#define ANTUI_UI_TitleBar_AUImageTextTitleView
#define ANTUI_UI_IconFont_AUIconView
#define ANTUI_UI_Label_TTTAttributedLabel
#define ANTUI_UI_ResultView_AUResultView
#define ANTUI_UI_Tableview_AUMultiListItem
#define ANTUI_UI_Tableview_AUListSeparatorLine
#define ANTUI_UI_alert_AUImageDialog
#define ANTUI_UI_amountInputBox_SimpleAmountInput
#define ANTUI_UI_updateTips_AUUpdateTips
#define ANTUI_UI_alert_AUCustomDialog
#define ANTUI_UI_pickerView_PickerBaseView
#define ANTUI_UI_ResultView_AULargeResultView
#define ANTUI_UI_Tableview_AUSingleTitleListItem
#define ANTUI_UI_actionSheet_AUActionSheet
#define ANTUI_UI_Segment_AUTitleBarSegment
#define ANTUI_UI_CardMenu_AUCardMenu
#define ANTUI_UI_BaseComponent_AUSubscriptButton
#define ANTUI_UI_TitleBar_AUCustomNavigationBar
#define ANTUI_UI_Segment_AUSegment
#define ANTUI_UI_amountInputBox_AUAmountInputBox
#define ANTUI_UI_Label_AURichTextLabel
#define ANTUI_UI_alert_AUInputDialog
#define ANTUI_UI_alert_AUNoticeDialog
#define ANTUI_UI_TitleBar_AUNavigationBar
#define ANTUI_UI_pickerView_AUDatePicker
#define ANTUI_UI_BaseComponent_AUWindow
#define ANTUI_UI_textfields_AUSecurityCodeBox
#define ANTUI_UI_Tableview_AUSwitchListItem
#define ANTUI_UI_BaseComponent_AUImage
#define ANTUI_UI_BannerView_AUBannerView
#define ANTUI_UI_TitleBar_AUBarButtonItem
#define ANTUI_UI_textfields_AUTextCodeInputBox
#define ANTUI_UI_refreshLoadingView_AURefreshView
#define ANTUI_UI_textfields_AUImageInputBox
#define ANTUI_UI_PopMenu_AUPopMenu
#define ANTUI_UI_BaseComponent_AULabel
#define ANTUI_UI_floatTip_AURecordFloatTip
#define ANTUI_UI_Search_AUSearchTitleView
#define ANTUI_UI_BaseComponent_AUImageView
#define ANTUI_UI_Tableview_AUParallelTitleListItem
#define ANTUI_UI_Toast_AUToast
#define ANTUI_UI_AgreementView_AUAgreementView
#define ANTUI_UI_actionSheet_AUCustomActionSheet
#define ANTUI_UI_refreshLoadingView_AUDragLoadingView
#define ANTUI_UI_BaseComponent_AUScrollView
#define ANTUI_UI_Tableview_AUCheckBoxListItem
#define ANTUI_UI_BaseComponent_AUListButtonPanel
#define ANTUI_UI_NetError_AUEmptyPageLoadingView
#define ANTUI_UI_textfields_AUParagraphInputBox
#define ANTUI_UI_Search_AUSearchBar
#define ANTUI_UI_FilterMenuView_AUFilterMenuView
#define ANTUI_UI_BaseComponent_AUActivityIndicatorView
#define ANTUI_UI_BaseComponent_PageFooter
#define ANTUI_UI_keyboards_AUNumKeyboards
#define ANTUI_UI_BaseComponent_AUSwitch
#define ANTUI_UI_BaseComponent_AULoadingIndicatorView
#define ANTUI_UI_refreshLoadingView_AUPullLoadingView
#define ANTUI_UI_FloatMenu_AUFloatMenu
#define ANTUI_UI_Tableview_AUAssitLableView
#define ANTUI_UI_amountInputBox_Deprecated
#define ANTUI_UI_Tableview_AUBankCardItem
#define ANTUI_UI_Tableview_AUTableview
#define ANTUI_UI_BaseComponent_AUActionButton
#define ANTUI_UI_Search_AUSearchInputBox
#define ANTUI_UI_checkbox_AUCheckBox
#define ANTUI_UI_textfields_AUInputBox
#define ANTUI_UI_pickerView_AUImagePicker
#define ANTUI_UI_Tableview_AULineBreakListItem
#define ANTUI_UI_Tableview_AUCouponsItem
#define ANTUI_UI_PopTip_AUPopTipView
#define ANTUI_UI_bladeView_AUBladeView

//加载的【Base 模块】
#define ANTUI_UI_textfields
#define ANTUI_UI_PopMenu
#define ANTUI_UI_AgreementView
#define ANTUI_UI_checkbox
#define ANTUI_UI_alert
#define ANTUI_UI_PopTip
#define ANTUI_UI_amountInputBox
#define ANTUI_UI_Navigate
#define ANTUI_UI_NetError
#define ANTUI_UI_updateTips
#define ANTUI_UI_QRCode
#define ANTUI_UI_FloatMenu
#define ANTUI_UI_Tableview
#define ANTUI_UI_pickerView
#define ANTUI_UI_keyboards
#define ANTUI_UI_FilterMenuView
#define ANTUI_UI_CardMenu
#define ANTUI_UI_Toast
#define ANTUI_UI_refreshLoadingView
#define ANTUI_UI_bladeView
#define ANTUI_UI_BaseComponent
#define ANTUI_UI_actionSheet
#define ANTUI_UI_Label
#define ANTUI_UI_TitleBar
#define ANTUI_UI_floatTip
#define ANTUI_UI_BannerView
#define ANTUI_UI_Segment
#define ANTUI_UI_Search
#define ANTUI_UI_IconFont
#define ANTUI_UI_ResultView
#define ANTUI_UI_BadgeView








//全局左右边距
#define kDemoGlobalMargin 15.0

//屏幕宽度 - 左右边距(15*2)
#define kDemoGlobalWidth (AUCommonUIGetScreenWidth() - kDemoGlobalMargin * 2)

//全局背景颜色
#define kDemoGlobalBackgroundColor RGB(0xf5f5f5)

//全局cellHeight
#define kDemoGlobalCellHeight 44.0

#define kDemoNeedWartMarkt  1
#define kDemoWartMarkttag    201987

#endif /* MPFrameworkDemoDef_h */
