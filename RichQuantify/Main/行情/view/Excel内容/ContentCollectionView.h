//
//  ContentCollectionView.h
//  JoeExcelView
//
//  Created by 岳万里 on 2017/8/29.
//  Copyright © 2017年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCollectionView : UICollectionView
@property (nonatomic , strong) NSString *cellID;
@property (nonatomic, strong) NSArray *dataArray;
@end
