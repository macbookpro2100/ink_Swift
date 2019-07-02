//
//  MPPullRefreshVC.m
//  MPaaSDemo_abc
//
//  Created by shifei.wkp on 2018/9/7.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import "MPPullRefreshVC.h"

@interface MPPullRefreshVC () <AURefreshLoadingViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    BOOL _headerReloading;
    BOOL _footerReloading;
    BOOL _isHeader;
}

@property(nonatomic, strong) AUPullLoadingView *refreshHeaderView;
@property(nonatomic, strong) AUDragLoadingView *refreshFooterView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray* listArray;

@end

@implementation MPPullRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.listArray addObject:@"19"];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRGB:0xf5f5f9];
    self.tableView.separatorColor = [UIColor colorWithRGB:0xdddddd];
    [self.view addSubview:self.tableView];
    
    if (_refreshHeaderView == nil) {
        
        AUPullLoadingView *view = [[AUPullLoadingView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [view ShowLastPullDate:YES];
        [view ShowStatusLabel:NO];
        
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    if (_refreshFooterView == nil) {
        
        AUDragLoadingView *view = [[AUDragLoadingView alloc] initWithTableView:self.tableView bizType:@"demo" makeConfig:^(AUDragLoadingConfig *config) {
        //            config.endStateEnable = YES;
//            config.attachedBottomIfHalfContentView = YES;
        //            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 550, 200)];
        //            view.backgroundColor = [UIColor redColor];
        //            config.endStateView = view;
        }];
        _refreshFooterView = view;
        
        __weak typeof(self) weakSelf = self;
        __weak typeof(view) weakView = view;
        view.loadingBlock = ^(void) {
            [weakSelf reloadFooterTableViewDataSource];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf doneLoadingFooterTableViewData];
                [weakView setState:AUDragLoadingStateNormal];
                
                //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                    [weakView setState:AUDragLoadingStateNormal];
                //                });
            });
        };
        
        
        // 这一段应该放到初始化rpc的compeletion里面
        BOOL hasNextPage = YES;
        view.state = hasNextPage ? AUDragLoadingStateNormal : AUDragLoadingStateEnd;
    }
    
    _isHeader = YES;
}

- (void)startRpc:(dispatch_block_t)rpcBlock completion:(dispatch_block_t)rpcCompletion {
    // rpc调用结束后，执行completion
    if (rpcCompletion) {
        rpcCompletion();
    }
}

#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RefreshCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _listArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadHeaderTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    NSInteger first = [_listArray[0] integerValue] - 1;
    [_listArray insertObject:[NSString stringWithFormat:@"%li",(long)first] atIndex:0];
    
    _headerReloading = YES;
}

- (void)doneLoadingHeaderTableViewData{
    
    //  model should call this when its done loading
    _headerReloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.tableView reloadData];
    
}

- (void)reloadFooterTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    NSInteger count = [_listArray count];
    NSInteger last = [_listArray[count-1] integerValue] + 1;
    
    for (NSInteger i = 0; i < 3; i ++) {
        [_listArray addObject:[NSString stringWithFormat:@"%li",(long)(last + i)]];
    }
    
    _footerReloading = YES;
}

- (void)doneLoadingFooterTableViewData{
    
    //  model should call this when its done loading
    _footerReloading = NO;
    //    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.tableView reloadData];
    
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentInset.top + scrollView.contentOffset.y < 0) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        _isHeader = YES;
    } else {
        _isHeader = NO;
    }
    
    [_refreshFooterView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_isHeader) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    } else {
        //        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark AURefreshLoadingViewDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(AUPullLoadingView*)view
{
    if (_isHeader) {
        [self reloadHeaderTableViewDataSource];
        [self performSelector:@selector(doneLoadingHeaderTableViewData) withObject:nil afterDelay:2.0];
    } else {
        [self reloadFooterTableViewDataSource];
        [self performSelector:@selector(doneLoadingFooterTableViewData) withObject:nil afterDelay:2.0];
    }
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(AUPullLoadingView*)view
{
    if (_isHeader) {
        return _headerReloading;
    } else {
        return _footerReloading; // should return if data source model is reloading
    }
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(AUPullLoadingView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 10; i++) {
            [_listArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _listArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
