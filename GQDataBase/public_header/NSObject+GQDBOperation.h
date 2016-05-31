//
//  NSObject+GQDBOperation.h
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (GQDBOperation)

/**
 *  增加or修改
 */
- (BOOL)gq_DBaddOrUpdate;

/**
 *  删除
 */
- (BOOL)gq_DBdel;

/**
 *  查询
 *
 *  @param predicate 正则
 *
 *  @return 结果
 */
+ (NSArray *)gq_DBgetObjectsWithPredicate:(NSPredicate *)predicate;

/**
 *  查询全部
 *
 *  @return 结果
 */
+ (NSArray *)gq_DBgetAllObject;

/**
 *  删除全部
 *
 */
+ (BOOL)gq_DBdelAll;
@end
