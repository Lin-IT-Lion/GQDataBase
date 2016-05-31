//
//  GQModelTransformer.m
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import "GQModelTransformer.h"
#import "MJExtension.h"
#import "RLMObject+JSON.h"
//#import "NSObject+GQNoramlModel_Private.h"
NSString *const classDBModelName = @"DBModel";
NSString *const classNormalModelName = @"Model";

@implementation GQModelTransformer

+ (Class)gq_DBClassName:(Class)noramlModelName
{
    static NSMutableDictionary *dic;
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }

    NSString *nowClassName = NSStringFromClass(noramlModelName);
    NSArray *components = [nowClassName componentsSeparatedByString:@"_"];
    nowClassName = components.lastObject;
    NSString *DBClassName = dic[nowClassName];
    
    if (DBClassName.length == 0) {
        
        NSRange isDBModelNameRange = [nowClassName rangeOfString:classDBModelName];
        if (isDBModelNameRange.length > 0) {
            return NSClassFromString(nowClassName);
        }
        
        NSRange range = [nowClassName rangeOfString:classNormalModelName];
        if (range.length > 0) {
            DBClassName = [nowClassName stringByReplacingOccurrencesOfString:classNormalModelName withString:classDBModelName];
        } else {
            DBClassName = [NSString stringWithFormat:@"%@%@",nowClassName,classDBModelName];
        }
        dic[nowClassName] = DBClassName;
    }
    
    return NSClassFromString(DBClassName);
}

+ (NSString *)gq_NormalClassName:(Class)gqBaseDBModelName
{
    static NSMutableDictionary *dic;
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }
    NSString *nowClassName = NSStringFromClass(gqBaseDBModelName);
    NSArray *components = [nowClassName componentsSeparatedByString:@"_"];
    nowClassName = components.lastObject;
    
    NSString *normalClassName = dic[nowClassName];
    if (normalClassName.length == 0) {
        
        NSRange isDBModelNameRange = [nowClassName rangeOfString:classDBModelName];
        if (isDBModelNameRange.length == 0) {
            return nowClassName;
        }
        
        NSRange range = [nowClassName rangeOfString:classDBModelName];
        if (range.length > 0) {
            normalClassName = [nowClassName stringByReplacingOccurrencesOfString:classDBModelName withString:classNormalModelName];
        } else {
            normalClassName = [NSString stringWithFormat:@"%@%@",nowClassName,classNormalModelName];
        }
        dic[nowClassName] = normalClassName;
    }
    return normalClassName;
}

+ (GQBaseDBModel *)transformerDBModelWithNormalModel:(NSObject *)noramlModel
{
    if ([noramlModel isKindOfClass:[GQBaseDBModel class]]) {
        return (GQBaseDBModel *)noramlModel;
    }
    NSDictionary *dic = [noramlModel mj_JSONObject];
    Class dbClass = [self gq_DBClassName:noramlModel.class];
    return [[dbClass alloc] initWithJSONDictionary:dic];
}

+ (NSObject *)transformerNormalModelWithDBModel:(GQBaseDBModel *)DBModel
{
    if ([DBModel isKindOfClass:[GQBaseDBModel class]] == NO) {
        return DBModel;
    }
    NSDictionary *dic = [DBModel JSONDictionary];
    Class normalClass = NSClassFromString([self gq_NormalClassName:DBModel.class]);
    return [normalClass mj_objectWithKeyValues:dic];
}


+ (NSArray<NSArray *> *)transformerDBModelWithNormalModelList:(NSArray<NSObject *> *)list
{
    NSMutableArray *mutableList = [NSMutableArray arrayWithArray:list];
    NSMutableArray *arry = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0 ;i < mutableList.count ; i ++) {
        NSObject *object = mutableList[i];
        if ([object isKindOfClass:[NSMutableArray class]] || [object isKindOfClass:[NSArray class]] ) {
            [mutableList addObjectsFromArray:object];
            [mutableList removeObject:object];
            i--;
        } else {
            GQBaseDBModel *model = [self transformerDBModelWithNormalModel:object];
            NSMutableArray *modelList = dic[model.class];
            if (modelList == nil) {
                modelList = [NSMutableArray array];
            }
            [modelList addObject:model];
            dic[model.class] = modelList;
        }
    }
    for (NSArray *modelList in [dic allValues]) {
        [arry addObject:modelList];
    }
    return arry;
}

+ (NSArray<NSObject *> *)transformerNormalModelWithBDModelList:(NSArray<GQBaseDBModel *> *)list
{
    NSMutableArray *arry = [NSMutableArray array];
    
    for (GQBaseDBModel *dbModel in list) {
        NSObject *model = [self transformerNormalModelWithDBModel:dbModel];
        if (model) {
            [arry addObject:model];
        }
    }
    return arry;
}


@end
