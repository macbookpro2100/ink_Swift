//
//  InkBaseViewController.m
//  MPFrameworkDemo_plugin
//
//  Created by macbookpro2100 on 12/2/19.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "InkBaseViewController.h"
#import <APLog/APLog.h>
@interface InkBaseViewController ()

@end

@implementation InkBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    APLogMonitor(@"[dealloc info]",@"\n******************************************\n******  ViewController dealloc  **********\n******  %@\n******************************************\n\n\n", [self class]);
}
@end
