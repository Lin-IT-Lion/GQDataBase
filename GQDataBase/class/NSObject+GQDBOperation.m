//
//  NSObject+GQDBOperation.m
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import "NSObject+GQDBOperation.h"
#import "GQModelTransformer.h"
#import "GQModelDBContext.h"

@implementation NSObject (GQDBOperation)

/**
 *  增加or修改
 */
- (BOOL)gq_DBaddOrUpdate
{
    if ([self isKindOfClass:[NSObject class]] == NO) {
        return NO;
    }
    if ([self isKindOfClass:[NSArray class]]|| [self isKindOfClass:[NSMutableArray class]]) {
        NSArray *arry = (NSArray *)self;
        NSArray<NSArray *> *list = [GQModelTransformer transformerDBModelWithNormalModelList:arry];
        for (NSArray * modelList in list) {
            [GQModelDBContext gq_DBaddOrUpateDBModelList:modelList];
        }
        return YES;
    }
    if ([self isKindOfClass:[GQBaseDBModel class]]) {
        return [GQModelDBContext gq_DBaddOrUpateDBModelList:@[self]];
    } else {
        GQBaseDBModel *model = [GQModelTransformer transformerDBModelWithNormalModel:self];
        return [model gq_DBaddOrUpdate];
    }
    return NO;
}

/**
 *  删除
 */
- (BOOL)gq_DBdel
{
    GQBaseDBModel *model = [GQModelTransformer transformerDBModelWithNormalModel:self];
    [GQModelDBContext gq_DBdelDBModel:model];
    return YES;
}

/**
 *  查询
 *
 *  @param predicate 正则
 *
 *  @return 结果
 */
+ (NSArray *)gq_DBgetObjectsWithPredicate:(NSPredicate *)predicate
{
    Class dbModelClassName = [GQModelTransformer gq_DBClassName:[self class]];
    NSArray *list = [GQModelDBContext gq_DBgetDBModelList:dbModelClassName withPredicate:predicate];
    return [GQModelTransformer transformerNormalModelWithBDModelList:list];
}

/**
 *  查询全部
 *
 *  @return 结果
 */
+ (NSArray *)gq_DBgetAllObject
{
    Class dbModelClassName = [GQModelTransformer gq_DBClassName:[self class]];
    NSArray *list = [GQModelDBContext gq_DBgetAllDBModel:dbModelClassName];
    
    return [GQModelTransformer transformerNormalModelWithBDModelList:list];
}

+ (BOOL)gq_DBdelAll
{
    Class dbModelClassName = [GQModelTransformer gq_DBClassName:[self class]];
    return [GQModelDBContext gq_DBdelAllDBModel:dbModelClassName];
}
@end
