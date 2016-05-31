//
//  GQModelDBContext.h
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import <Foundation/Foundation.h>
#import "GQBaseDBModel.h"
@interface GQModelDBContext : NSObject

+ (id)gq_DBcurrentRealm:(Class)dbModelClassName;

+ (BOOL)gq_DBaddOrUpateDBModelList:(NSArray <GQBaseDBModel *> *)dbModellist;

+ (BOOL)gq_DBdelDBModel:(GQBaseDBModel *)dbModel;

+ (BOOL)gq_DBdelAllDBModel:(Class)dbModelClassName;

+ (NSArray *)gq_DBgetAllDBModel:(Class)dbModelClassName;

+ (NSArray *)gq_DBgetDBModelList:(Class )dbModelClassName withPredicate:(NSPredicate *)predicate;

@end
