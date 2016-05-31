//
//  GQNormalDBModel.h
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/20.
//  Copyright © 2016年 林国强. All rights reserved.
//

#import "GQBaseDBModel.h"
#import "GQSecNormalModel.h"

RLM_ARRAY_TYPE(GQSecNormalDBModel)

@interface GQNormalDBModel : GQBaseDBModel

@property (nonatomic, strong) NSNumber<RLMInt> *nId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) GQSecNormalDBModel *oneModel;

@property (nonatomic, strong) RLMArray<GQSecNormalDBModel> *oneModelList;
@end
