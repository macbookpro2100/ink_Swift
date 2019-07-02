#import "APCommonUI_ForDemo_Dic.h"

@implementation APCommonUI_ForDemo_theme1
+ (NSMutableDictionary *)theme1_dic
{
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];//
dict[@"TITLEBAR_ITEM_LEFT_RIGHT_MARGIN"] = @"16";
// "STATUSBAR_DEFAULT_COLOR"       = "CONSTANT(AU_COLOR_UNIVERSAL_BG)"; // 使用 AntUI中的常量色值
dict[@"TITLEBAR_TEXTSIZE"] = @"15";
/* 代表粗字体*/
dict[@"TITLEBAR_TEXTSIZE_BOLD"] = @"15, bold"; 
dict[@"TITLEBAR_LINE_COLOR"] = @"#dddddd";
dict[@"TITLEBAR_ICON_COLOR"] = @"#dddddd, 0.4";
/**/
dict[@"TITLEBAR_ICON_SIZE"] = @"320, 44"; 
dict[@"SEARCHBAR_VOICE_ICON_IMAGE"] = @"APCommonUI.bundle/searchbar/voice_button";
dict[@"AU_TEXT_ADAPTOR_HEIGHT"] = @"6";
dict[@"AU_DEMO_IMAGE1_ICON_PATH"] = @"APCommonUI_ForDemo.bundle/details_white";
return dict;
}

+ (NSMutableDictionary *)theme1_320_568_dic
{
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];//
dict[@"TITLEBAR_ITEM_LEFT_RIGHT_MARGIN"] = @"16";
//"STATUSBAR_DEFAULT_COLOR"       = "CONSTANT(AU_COLOR_UNIVERSAL_BG)"; // 使用 AntUI中的常量色值
dict[@"TITLEBAR_TEXTSIZE"] = @"15";
/* 代表粗字体*/
dict[@"TITLEBAR_TEXTSIZE_BOLD"] = @"15, bold"; 
dict[@"TITLEBAR_LINE_COLOR"] = @"#dddddd";
dict[@"TITLEBAR_ICON_COLOR"] = @"#dddddd, 0.4";
/**/
dict[@"TITLEBAR_ICON_SIZE"] = @"22, 22"; 
dict[@"SEARCHBAR_VOICE_ICON_IMAGE"] = @"APCommonUI.bundle/searchbar/voice_button";
dict[@"AU_TEXT_ADAPTOR_HEIGHT"] = @"49999";
return dict;
}

+ (NSMutableDictionary *)theme1_x_dic
{
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];//
dict[@"TITLEBAR_ITEM_LEFT_RIGHT_MARGIN"] = @"16";
//"STATUSBAR_DEFAULT_COLOR"       = "CONSTANT(AU_COLOR_UNIVERSAL_BG)"; // 使用 AntUI中的常量色值
dict[@"TITLEBAR_TEXTSIZE"] = @"15";
/* 代表粗字体*/
dict[@"TITLEBAR_TEXTSIZE_BOLD"] = @"15, bold"; 
dict[@"TITLEBAR_LINE_COLOR"] = @"#dddddd";
dict[@"TITLEBAR_ICON_COLOR"] = @"#dddddd, 0.4";
/**/
dict[@"TITLEBAR_ICON_SIZE"] = @"320, 44"; 
dict[@"SEARCHBAR_VOICE_ICON_IMAGE"] = @"APCommonUI.bundle/searchbar/voice_button";
//addToTheme("SEARCHBAR_VOICE_ICON_IMAGE"    ,"APCommonUI.bundle/searchbar/voice_button")
dict[@"AU_TEXT_ADAPTOR_HEIGHT"] = @"812";
#define addToTheme
return dict;
}

+ (NSMutableDictionary *)theme1_320_dic
{
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];//
dict[@"TITLEBAR_ITEM_LEFT_RIGHT_MARGIN"] = @"16";
//"STATUSBAR_DEFAULT_COLOR"       = "CONSTANT(AU_COLOR_UNIVERSAL_BG)"; // 使用 AntUI中的常量色值
dict[@"TITLEBAR_TEXTSIZE"] = @"15";
/* 代表粗字体*/
dict[@"TITLEBAR_TEXTSIZE_BOLD"] = @"15, bold"; 
dict[@"TITLEBAR_LINE_COLOR"] = @"#dddddd";
dict[@"TITLEBAR_ICON_COLOR"] = @"#dddddd, 0.4";
/**/
dict[@"TITLEBAR_ICON_SIZE"] = @"22, 22"; 
dict[@"SEARCHBAR_VOICE_ICON_IMAGE"] = @"APCommonUI.bundle/searchbar/voice_button";
return dict;
}

+ (NSMutableDictionary *)theme1_375_dic
{
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];//
dict[@"TITLEBAR_ITEM_LEFT_RIGHT_MARGIN"] = @"16";
//"STATUSBAR_DEFAULT_COLOR"       = "CONSTANT(AU_COLOR_UNIVERSAL_BG)"; // 使用 AntUI中的常量色值
dict[@"TITLEBAR_TEXTSIZE"] = @"15";
/* 代表粗字体*/
dict[@"TITLEBAR_TEXTSIZE_BOLD"] = @"15, bold"; 
dict[@"TITLEBAR_LINE_COLOR"] = @"#dddddd";
dict[@"TITLEBAR_ICON_COLOR"] = @"#dddddd, 0.4";
/**/
dict[@"TITLEBAR_ICON_SIZE"] = @"22, 22"; 
dict[@"SEARCHBAR_VOICE_ICON_IMAGE"] = @"APCommonUI.bundle/searchbar/voice_button";
return dict;
}

@end
