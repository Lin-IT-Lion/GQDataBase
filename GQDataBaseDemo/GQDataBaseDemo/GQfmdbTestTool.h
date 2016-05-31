//
//  GQfmdbTestTool.h
//  GQDataBaseDemo
//
//  Created by 林国强 on 16/5/31.
//  Copyright © 2016年 林国强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQfmdbTestTool : NSObject
+ (void)saveList:(NSArray <GQNormalModel *>*)list;
+ (NSArray <GQNormalModel *>*)getAllTestList;
+ (void)delAll;
@end
