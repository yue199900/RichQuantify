//
//  MarketViewController.m
//  RichQuantify
//
//  Created by 岳万里 on 2017/9/11.
//  Copyright © 2017年 岳万里. All rights reserved.
//

#import "MarketViewController.h"
#define TopMenumargin 40
#define MarketLineLeftMargin 20
@interface MarketViewController ()<UIScrollViewDelegate>

/*中间自选，行情按钮*/
@property (nonatomic, strong) UISegmentedControl *navSegment;
/*上证当前行情*/
@property (weak, nonatomic) IBOutlet UILabel *ShanghaiCompositeCurrentLabel;
/*上证当前百分比*/
@property (weak, nonatomic) IBOutlet UILabel *ShanghaiCompositePercentageLabel;
/*深证当前行情*/
@property (weak, nonatomic) IBOutlet UILabel *ShenzhenComponentCurrentLabel;
/*深证当前百分比*/
@property (weak, nonatomic) IBOutlet UILabel *ShenzhenComponentPercentageLabel;

@property (weak, nonatomic) IBOutlet UIView *topBaseView;
/*股票Excelview*/
@property (nonatomic, strong)JoeExcelView *stockExcelView;
/*搜索按钮*/
@property (nonatomic, strong) UIButton *searchButton;
/*编辑按钮*/
@property (nonatomic, strong) UIButton *editButton;


/*行情菜单栏*/
@property (weak, nonatomic) IBOutlet UIView *marketTopMenuView;
/*行情scrollview*/
@property (weak, nonatomic) IBOutlet UIScrollView *marketscrollView;
/*行情菜单栏下的选中线*/
@property (weak, nonatomic) IBOutlet UIView *marketLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marketLineX;
@end

@implementation MarketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationControllerButton];
    self.marketscrollView.pagingEnabled = YES;
}

#pragma mark--- 添加导航控制器头部按钮
- (void)addNavigationControllerButton
{
    /************添加中间自选，行情按钮****************/
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"自选",@"行情"]];
    segment.frame = CGRectMake(0, 0, 150, 31);
    segment.selectedSegmentIndex = 1;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navSegment = segment;
    self.navigationItem.titleView = self.navSegment;
    
    /*******添加右侧编辑，搜索按钮*******/
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake( 0, 0, 25, 25);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton = searchBtn;
    UIBarButtonItem *searchBar = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake( 0, 0, 25, 25);
    [editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    self.editButton = editBtn;
    editBtn.hidden = YES;
    UIBarButtonItem *editBar = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItems = @[searchBar,editBar];
}

#pragma segment响应方法
- (void)segmentAction:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
       /**********自选************/
         NSLog(@"自选");
        [self addStockExcelView];
        self.topBaseView.hidden = NO;
        self.editButton.hidden = NO;
        self.marketscrollView.hidden = YES;
        self.marketTopMenuView.hidden = YES;
    }
    else
    {
        /**********行情************/
         NSLog(@"行情");
        self.topBaseView.hidden = YES;
        self.stockExcelView.hidden = YES;
        self.editButton.hidden = YES;
        self.marketscrollView.hidden = NO;
        self.marketTopMenuView.hidden = NO;
    }
}

#pragma mark --- 搜索按钮事件
- (void)searchAction:(UIButton *)sender
{
    NSLog(@"搜索");
}

#pragma mark --- 编辑按钮事件
- (void)editAction:(UIButton *)sender
{
     NSLog(@"编辑");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 资金按钮事件
- (IBAction)capitalButtonAction:(UIButton *)sender
{
    NSLog(@"资金");
}

#pragma mark --- 资讯按钮事件
- (IBAction)informationButtonAction:(UIButton *)sender
{
    NSLog(@"资讯");
}


#pragma mark ---- 添加股票Excelview
- (void)addStockExcelView
{
    self.stockExcelView = [[JoeExcelView alloc] initWithFrame:CGRectMake(0, 65, SCREENWIDTH, SCREENHEIGHT-65-64-49)];
    [self.view addSubview:self.stockExcelView];
    self.stockExcelView.indexBlock = ^(NSString *cellID)
    {
        NSLog(@"cellID:%@",cellID);
    };
    self.stockExcelView.hidden = NO;
}

#pragma mark --- 顶部菜单栏选项事件
- (IBAction)topMenuItemAction:(UIButton *)sender
{
    if(sender.tag == 201701)
    {
        self.marketscrollView.contentOffset = CGPointMake(0, 0);
        self.marketLineX.constant = MarketLineLeftMargin;
        
    }
    else if(sender.tag == 201702)
    {
        self.marketscrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
        self.marketLineX.constant = self.marketLine.width + TopMenumargin + MarketLineLeftMargin;
        
    }
    else if (sender.tag == 201703)
    {
        self.marketscrollView.contentOffset = CGPointMake(2*SCREENWIDTH, 0);
        self.marketLineX.constant = (self.marketLine.width + TopMenumargin)*2 +MarketLineLeftMargin ;
        
    }
    else
    {
        self.marketscrollView.contentOffset = CGPointMake(3*SCREENWIDTH, 0);
        self.marketLineX.constant = (self.marketLine.width + TopMenumargin)*3 +MarketLineLeftMargin ;
    }
}


#pragma mark ---- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    if(x/SCREENWIDTH == 0)
    {
        self.marketLineX.constant = MarketLineLeftMargin;
    }
    else if (x/SCREENWIDTH == 1)
    {
        self.marketLineX.constant = self.marketLine.width + TopMenumargin + MarketLineLeftMargin;
    }
    else if (x/SCREENWIDTH == 2)
    {
        self.marketLineX.constant = (self.marketLine.width + TopMenumargin)*2 +MarketLineLeftMargin ;
    }
    else
    {
        self.marketLineX.constant = (self.marketLine.width + TopMenumargin)*3 +MarketLineLeftMargin ;
    }
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
