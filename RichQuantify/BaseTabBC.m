//
//  BaseTabBC.m
//  ShoppingCentre
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 漫步太阳. All rights reserved.
//

#import "BaseTabBC.h"
#import "BaseNC.h"

@interface BaseTabBC ()
@property(nonatomic , strong) NSMutableArray *vcArray;//保存子控制器的数组
@end

@implementation BaseTabBC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //准备数据
     NSArray *nameArray = @[
  @{
      @"storyboardName":@"StrategyStoryboard",
      @"vcID":@"StrategyViewController",
      @"title":@"策略",
      @"imageName":@"strategy",
      @"selectImageName":@"strategy-Selected"
      },
  @{
      @"storyboardName":@"SelectStockStoryboard",
      @"vcID":@"SelectStockViewController",
      @"title":@"选股",
      @"imageName":@"Choice",
      @"selectImageName":@"Choice-Selected"
      },
  @{
      @"storyboardName":@"MarketStoryboard",
      @"vcID":@"MarketViewController",
      @"title":@"行情",
      @"imageName":@"Quotation",
      @"selectImageName":@"Quotation-Selected"
      },
  @{
      @"storyboardName":@"MyStoryboard",
      @"vcID":@"MyViewController",
      @"title":@"我的",
      @"imageName":@"My",
      @"selectImageName":@"My-Selected"
      }
  ];
    //添加子控制器
    [self addSubVCWithTitleArray:nameArray];
}

#pragma mark --- 保存子控制器的数组，懒加载方法
- (NSMutableArray *)vcArray
{
    if(!_vcArray)
    {
        _vcArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _vcArray;
}

#pragma mark --- 添加子控制器
- (void)addSubVCWithTitleArray:(NSArray *)nameArray
{
    for(NSDictionary *dict in nameArray)
    {
        UIViewController *vc = [self initVCFromstoryboard:dict[@"storyboardName"] andVCName:dict[@"vcID"]];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:dict[@"title"] image:[[UIImage imageNamed:dict[@"imageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:dict[@"selectImageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        vc.title = dict[@"title"];
        [self.vcArray addObject:[[BaseNC alloc] initWithRootViewController:vc]];
    }
    
    self.viewControllers = self.vcArray;
    self.selectedIndex = 0;
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1]} forState:UIControlStateNormal];
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:36/255.0 green:137/255.0 blue:232/255.0 alpha:1]} forState:UIControlStateSelected];
}

#pragma mark --- 从storyboard初始化控制器
/**
 从storyboard初始化控制器
 @param storyboardName storyboard名称
 @param vcID 控制器的storyboardID
 @return 返回的控制器
 */
- (UIViewController *)initVCFromstoryboard:(NSString *) storyboardName andVCName:(NSString *) vcID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:vcID];
}

- (void)didReceiveMemoryWarning
{
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
