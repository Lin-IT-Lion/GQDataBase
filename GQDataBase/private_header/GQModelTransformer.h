//
//  GQModelTransformer.h
//  Pods
//
//  Created by 林国强 on 16/5/20.
//
//

#import <Foundation/Foundation.h>
#import "GQBaseDBModel.h"
@interface GQModelTransformer : NSObject

+ (Class)gq_DBClassName:(Class)noramlModelName;

+ (NSString *)gq_NormalClassName:(Class)gqBaseDBModelName;

+ (__kindof GQBaseDBModel *)transformerDBModelWithNormalModel:(NSObject *)noramlModel;

+ (NSObject *)transformerNormalModelWithDBModel:(GQBaseDBModel *)DBModel;

+ (NSArray<NSArray *> *)transformerDBModelWithNormalModelList:(NSArray<NSObject *> *)list;

+ (NSArray<NSObject *> *)transformerNormalModelWithBDModelList:(NSArray<GQBaseDBModel *> *)list;

@end
