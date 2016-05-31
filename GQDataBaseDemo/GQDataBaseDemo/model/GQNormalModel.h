//
//  GQNormalModel.h
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/20.
//  Copyright © 2016年 林国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQSecNormalModel.h"
@interface GQNormalModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSNumber *nId;

@property (nonatomic, strong) GQSecNormalModel *oneModel;

@property (nonatomic, strong) NSMutableArray *oneModelList;

@end
