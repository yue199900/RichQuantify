//
//  JoeExcelView.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "JoeExcelView.h"
#import "JContentTableView.h"
#import "TopCollectionView.h"
#import "JContentTableViewCell.h"
#import "JoeExcel.h"


@interface JoeExcelView ()

@property (nonatomic, strong) JContentTableView *jContentTableView;
@property (nonatomic, strong) TopCollectionView *topCollectionView;

@end


@implementation JoeExcelView
@synthesize jContentTableView;
@synthesize topCollectionView;


// -- 如果想在类外面处理ContentTableView和TopCollectionView可以将他们的Delegate和DataSource代理出来 例如JContentTableView中CollectionView的didSelected方法...
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UILabel *vNumLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 100, 30)];
        vNumLab.backgroundColor = [UIColor yellowColor];
        vNumLab.textAlignment = NSTextAlignmentCenter;
        vNumLab.text = @"我的自选";
        [self addSubview:vNumLab];
        
        // 顶部横向序号CollectionView
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        topCollectionView = [[TopCollectionView alloc] initWithFrame:CGRectMake(vNumLab.frame.size.width, frame.origin.y, frame.size.width-vNumLab.frame.size.width, 30) collectionViewLayout:collectionViewFlowLayout];
        topCollectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:topCollectionView];
        
        // 添加Observer
        [topCollectionView addObserver:self forKeyPath:TopCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        jContentTableView = [[JContentTableView alloc] initWithFrame:CGRectMake(0, vNumLab.frame.size.height+vNumLab.frame.origin.y,frame.size.width,frame.size.height-vNumLab.frame.size.height) style:UITableViewStylePlain];
        [self addSubview:jContentTableView];
         __weak typeof(self)weakSelf=self;
        jContentTableView.indexBlock = ^(NSString *cellID)
        {
            if(weakSelf.indexBlock)
            {
                weakSelf.indexBlock(cellID);
            }
        };
        // 添加Observer
        [jContentTableView addObserver:self forKeyPath:JContentTableViewCellCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}


- (id)valueForUndefinedKey:(NSString *)key
{
    return @"TopCollectionViewObserver";
}

#pragma mark --- Observer实现
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    
    if ([keyPath isEqualToString:TopCollectionViewObserver])
    {
        for (JContentTableViewCell* cell in jContentTableView.visibleCells)
        {
            for (UIView *view in cell.contentView.subviews)
            {
                if ([view isKindOfClass:[UICollectionView class]])
                {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = topCollectionView.contentOffset;
                    
                }
            }
        }
    }
    
    if ([keyPath isEqualToString:JContentTableViewCellCollectionViewObserver])
    {
        for (JContentTableViewCell *cell in jContentTableView.visibleCells)
        {
            for (UIView *view in cell.contentView.subviews)
            {
                if ([view isKindOfClass:[UICollectionView class]])
                {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    topCollectionView.contentOffset = collectionView.contentOffset;
                    
                }
            }
        }
    }
}

// 移除Observer
- (void)dealloc
{
    [topCollectionView removeObserver:self forKeyPath:TopCollectionViewObserver];
    [jContentTableView removeObserver:self forKeyPath:JContentTableViewCellCollectionViewObserver];
}
@end
