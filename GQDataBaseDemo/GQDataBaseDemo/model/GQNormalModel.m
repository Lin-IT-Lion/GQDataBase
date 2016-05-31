//
//  GQNormalModel.m
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/20.
//  Copyright © 2016年 林国强. All rights reserved.
//

#import "GQNormalModel.h"
#import "GQSecNormalModel.h"
@implementation GQNormalModel
- (NSMutableArray *)oneModelList
{
    if (_oneModelList == nil) {
        _oneModelList = [NSMutableArray array];
    }
    return _oneModelList;
}


@end
