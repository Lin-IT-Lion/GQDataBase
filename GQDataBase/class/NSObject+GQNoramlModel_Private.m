//
//  NSObject+GQNoramlModel_Private.m
//  Pods
//
//  Created by 林国强 on 16/5/31.
//
//

#import "NSObject+GQNoramlModel_Private.h"
#import "GQModelTransformer.h"
@implementation NSObject (GQNoramlModel_Private)
+ (NSDictionary *)mj_objectClassInArray
{
    Class DBModelClassName = [GQModelTransformer gq_DBClassName:self];
    if ([DBModelClassName respondsToSelector:@selector(modelClassInArray)]) {
        NSDictionary *dic = [DBModelClassName modelClassInArray];
        return dic;
    }
    return nil;
}
@end
