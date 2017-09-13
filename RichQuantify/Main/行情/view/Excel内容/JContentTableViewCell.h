//
//  JContentTableViewCell.h
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentCollectionView.h"
@interface JContentTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *leftTextLab;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) ContentCollectionView *contentCollectionView;
@end
