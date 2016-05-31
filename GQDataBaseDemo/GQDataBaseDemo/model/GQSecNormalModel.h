//
//  GQSecNormalModel.h
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/27.
//  Copyright © 2016年 林国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQBaseDBModel.h"
@interface GQSecNormalModel : NSObject
@property (nonatomic, copy) NSString *smallTitle;
@property (nonatomic, copy) NSString *smallTitle1;
@end

@interface GQSecNormalDBModel : GQBaseDBModel

@property (nonatomic, copy) NSString *smallTitle;
@property (nonatomic, copy) NSString *smallTitle1;
@end